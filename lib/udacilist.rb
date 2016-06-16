class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] if options[:title]
    @title = "Untitled List" if !options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      @items.push TodoItem.new(description, options)
    elsif type == "event"
      @items.push EventItem.new(description, options)
    elsif type == "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemTypeError, "#{type} is an invalid type"
    end
  end
  def delete(index)
    @items.delete_at(index - 1) if index <= @items.length
    raise UdaciListErrors::IndexExceedsListSizeError, "There are only #{@items.length} items" if index > @items.length
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    rows = []
    @items.each_with_index do |item, position|
      rows << [position+1, item.details]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end

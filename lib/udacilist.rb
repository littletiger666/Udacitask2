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
  def complete(description)
    task = @items.find {|item| item.description == description}
    @items.delete task
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
  def filter string
    match_items = @items.select {|item| item.type == string}
    if match_items == nil
      puts "no matched task"
    else
      rows = []
      match_items.each_with_index do |item, position|
        rows << [position+1, item.details]
      end
      table = Terminal::Table.new :rows => rows
      puts "matched taskes:\n"
      puts table
    end
  end
  def due_soon
    match_items = []
    @items.each do |item|
      if item.type == "todo"
        if item.due && item.due - Chronic.parse(Date.today) <= 86400
          match_items << item
        end
      elsif item.type == "event"
        if item.start_date && item.start_date - Chronic.parse(Date.today) <= 86400
          match_items << item
        end
      end
    end
    if match_items == []
      puts "There is no task due soon"
    else
      rows = []
      match_items.each_with_index do |item, position|
        rows << [position+1, item.details]
      end
      table = Terminal::Table.new :rows => rows
      puts "taskes that due soon:\n"
      puts table
    end
  end
end

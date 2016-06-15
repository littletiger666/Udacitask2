class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = Chronic.parse(options[:due]) if options[:due]
    @priority = options[:priority]
  end

  def type
    "todo"
  end


  def format_priority
    if @priority == "high"
      value = " ⇧"
    elsif @priority == "medium"
      value = " ⇨"
    elsif @priority == "low"
      value = " ⇩"
    elsif !@priority
      value = ""
    else
      raise InvalidPriorityValueError
    end
      
    return value
  end

end

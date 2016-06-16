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
      value = " ⇧".colorize(:red)
    elsif @priority == "medium"
      value = " ⇨".colorize(:yellow)
    elsif @priority == "low"
      value = " ⇩".colorize(:green)
    elsif !@priority
      value = ""
    else
      raise UdaciListErrors::InvalidPriorityValueError, "not a valid priority"
    end

    return value
  end

end

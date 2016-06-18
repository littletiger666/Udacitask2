module Listable
  # Listable methods go here
  def format_description(description)
    "#{self.type}) #{description}".ljust(30)
  end

  def format_date(options={})
    if self.type == "todo"
      due ? due.strftime("%D") : "No due date"
    elsif self.type == "event"
      dates = start_date.strftime("%D") if start_date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      return dates
    end
  end

  def details
    if self.type == "todo"
      format_description(description) + "due: " +
      format_date(due: due) +
      format_priority
    elsif self.type == "event"
      format_description(description) +
      "event dates: " +
      format_date(start_date: start_date, end_date: end_date)
    elsif self.type == "link"
      format_description(description) + "site name: " + format_name
    end
  end
end

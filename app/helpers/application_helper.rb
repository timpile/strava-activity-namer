module ApplicationHelper

  def conversion_helper from, to, value = 1
    if from == "meters" && to == "miles"
      (value * 0.000621371).round(1)
    elsif from == "seconds" && to == "minutes"
      (value / 60.0).round(1)
    elsif from == "mps" && to == "pace"
      (26.8224 / value).round(1)
    end
  end

  def day_part time
    t = time.to_i
    if t <= morning(time)
      "morning"
    elsif t <= noon(time)
      "lunch"
    elsif t <= evening(time)
      "afternoon"
    elsif t <= night(time)
      "evening"
    else
      "night"
    end
  end

  def morning datetime
    datetime.change(:hour => 11).to_i
  end

  def noon datetime
    datetime.change(:hour => 13).to_i
  end

  def evening datetime
    datetime.change(:hour => 15).to_i
  end

  def night datetime
    datetime.change(:hour => 20).to_i
  end

end

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

  def day_part datetime
    t = datetime
    if t <= morning(datetime)
      "morning"
    elsif t <= noon(datetime) && weekend?(datetime)
      ""
    elsif t <= noon(datetime)
      "lunch"
    elsif t <= evening(datetime)
      "afternoon"
    elsif t <= night(datetime)
      "evening"
    else
      "night"
    end
  end

  def morning datetime
    datetime.change(:hour => 11)
  end

  def noon datetime
    datetime.change(:hour => 13)
  end

  def evening datetime
    datetime.change(:hour => 15)
  end

  def night datetime
    datetime.change(:hour => 20)
  end

  def weekend? datetime
    ["6","7"].include?(datetime.strftime("%u"))
  end

end

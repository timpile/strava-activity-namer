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

end

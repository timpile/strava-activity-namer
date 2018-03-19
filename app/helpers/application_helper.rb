module ApplicationHelper

  def nav_helper
    if current_user
      (content_tag :li, (link_to "Activities", activities_path, class: "nav-link"), class: "nav-item active") +
      (content_tag :li, (link_to "Logout", destroy_user_session_path, method: :delete, class: "nav-link"), class: "nav-item active")
    else
      (content_tag :li, (link_to "Login", new_user_session_path, class: "nav-link"), class: "nav-item active") +
      (content_tag :li, (link_to "Register", new_user_registration_path, class: "nav-link"), class: "nav-item active")
    end
  end

  def conversion_helper from, to, value = 1
    if from == "meters" && to == "miles"
      "#{(value * 0.000621371).round(1)} miles"
    elsif from == "seconds" && to == "minutes"
      (value / 60.0).round(1)
    elsif from == "mps" && to == "pace"
      time = (26.8224 / value)
      min = time.floor
      sec = ((time - time.floor) * 60).round(0)
      format_sec = sec > 9 ? sec : "0#{sec}"
      "#{min}:#{format_sec} pace"
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

  def distance_buckets
    [
      {endurance: nil, low: 0, high: 0, adj: "", adverb: ""},
      {endurance: 1, low: 0, high: 7, adj: "short", adverb: "super"},
      {endurance: 2, low: 7, high: 20, adj: "short", adverb: ""},
      {endurance: 3, low: 20, high: 80, adj: "typical", adverb: ""},
      {endurance: 4, low: 80, high: 95, adj: "long", adverb: ""},
      {endurance: 5, low: 95, high: 100, adj: "longer", adverb: "slightly"},
    ]
  end

  def speed_buckets
    [
      {intensity: nil, low: 0, high: 0, adj: "", adverb: ""},
      {intensity: 1, low: 99, high: 100, adj: "killer", adverb: ""},
      {intensity: 2, low: 95, high: 99, adj: "fast", adverb: ""},
      {intensity: 3, low: 80, high: 95, adj: "quick", adverb: ""},
      {intensity: 4, low: 20, high: 80, adj: "normal", adverb: ""},
      {intensity: 5, low: 10, high: 20, adj: "easy", adverb: ""},
      {intensity: 6, low: 0, high: 10, adj: "easy", adverb: "super"},
    ]
  end

  def a_or_an word
    if word.strip[0].match(Regexp.new('[aeiou]')).nil?
      "a #{word}"
    else
      "an #{word}"
    end
  end

end

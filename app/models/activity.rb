class Activity < ApplicationRecord
  include ApplicationHelper
  belongs_to :user
  has_many :laps, dependent: :destroy

  def self.data_set
    where("start_date_local >= ? AND activity_type = ?", 60.days.ago, "Run")
  end

  def self.distance_data
    data_set.pluck(:distance).extend(DescriptiveStatistics)
  end

  def set_distance_percentile_rank!
    self.distance_percentile_rank = user.activities.distance_data.percentile_rank(distance)
    self.save!
  end

  def distance_bucket
    distance_buckets.find {|bucket| distance_percentile_rank > bucket[:low] && distance_percentile_rank <= bucket[:high]}
  end

  def speed_data
    @speed_data ||= user.activities.data_set.pluck(:average_speed).extend(DescriptiveStatistics)
  end

  def speed_percentile_rank
    speed_data.percentile_rank(average_speed).round(1)
  end

  def speed_bucket
    speed_buckets.find {|bucket| speed_percentile_rank > bucket[:low] && speed_percentile_rank <= bucket[:high]}
  end

  def distance_desc
    a_or_an("#{distance_bucket[:adverb]} #{distance_bucket[:adj]}")
  end

  def distance_in_words
    conversion_helper("meters","miles",distance)
  end

  def speed_desc
    a_or_an("#{speed_bucket[:adverb]} #{speed_bucket[:adj]}")
  end

  def speed_in_words
    conversion_helper("mps","pace",average_speed)
  end

  def time_of_day_in_words
    day_part(start_date_local)
  end

  def verb
    activity_type
  end

  def sentence_generator
    "#{distance_desc} #{time_of_day_in_words} #{verb} at #{speed_desc} pace (#{distance_in_words} @ #{speed_in_words})".downcase.humanize
  end

end

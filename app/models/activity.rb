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

  # Eventually refactor these methods into module?
  def distance_bucket
    b = distance_buckets[0]
    distance_buckets.each do |bucket|
      b = bucket if distance_percentile_rank > bucket[0] && distance_percentile_rank <= bucket[1]
    end
    return b
  end

  def speed_distance_descriptor
    "#{distance_bucket[2]} #{day_part(start_date_local)} #{activity_type.downcase} at a(n) #{speed_bucket[2]} pace"
  end

  def speed_percentile_rank
    user.activities.data_set.where("distance_percentile_rank > ? AND distance_percentile_rank <= ?", distance_bucket[0], distance_bucket[1]).pluck(:average_speed).extend(DescriptiveStatistics).percentile_rank(average_speed).round(1)
  end

  def speed_bucket
    s = speed_buckets[0]
    speed_buckets.each do |bucket|
      s = bucket if speed_percentile_rank > bucket[0] && speed_percentile_rank <= bucket[1]
    end
    return s
  end

  def new_name
    # {start_date_local.strftime("%A")}
    "#{speed_distance_descriptor.capitalize}.
    (About #{conversion_helper("meters","miles",distance)} miles)"
  end

end

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

  def self.speed_data
    data_set.pluck(:average_speed).extend(DescriptiveStatistics)
  end

  def set_distance_percentile_rank!
    self.distance_percentile_rank = user.activities.distance_data.percentile_rank(distance)
    self.save!
  end

  # Eventually refactor these methods into module?
  def distance_descriptor
    if distance_percentile_rank.blank?
      ""
    elsif distance_percentile_rank < 20
      "short"
    elsif distance_percentile_rank < 80
      ""
    elsif distance_percentile_rank < 95
      "long"
    else
      "really long"
    end
  end

  def new_name
    # {start_date_local.strftime("%A")}
    "
    #{distance_descriptor.capitalize}
    #{day_part(start_date_local)}
    #{activity_type.downcase}
    for #{conversion_helper("meters","miles",distance)} miles
    "
  end

end

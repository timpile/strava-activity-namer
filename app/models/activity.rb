class Activity < ApplicationRecord
  include ApplicationHelper
  belongs_to :user
  has_many :laps

  def self.data_set
    where("start_date_local >= ?", 60.days.ago)
  end

  def self.data_analysis field
    data_set.pluck(:"#{field}").extend(DescriptiveStatistics)
  end

  def new_name
    "#{start_date_local.strftime("%A")}
    #{day_part(start_date_local)}
    #{conversion_helper("meters","miles",distance)} mile
    #{activity_type.downcase}"
  end

end

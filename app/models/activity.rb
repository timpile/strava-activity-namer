class Activity < ApplicationRecord
  belongs_to :user
  has_many :laps
end

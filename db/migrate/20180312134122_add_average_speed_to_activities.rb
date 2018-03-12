class AddAverageSpeedToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :average_speed, :float
  end
end

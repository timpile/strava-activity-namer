class AddDistancePercentileRankToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :distance_percentile_rank, :float
  end
end

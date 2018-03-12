class CreateLaps < ActiveRecord::Migration[5.1]
  def change
    create_table :laps do |t|
      t.references :activity, foreign_key: true
      t.bigint :strava_id
      t.string :name
      t.integer :elapsed_time
      t.float :distance
      t.float :average_speed
      t.integer :lap_index

      t.timestamps
    end
  end
end

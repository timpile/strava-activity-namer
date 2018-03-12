class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.bigint :strava_id
      t.string :name
      t.string :activity_type
      t.timestamp :start_date_local
      t.integer :elapsed_time
      t.text :description
      t.integer :distance

      t.timestamps
    end
  end
end

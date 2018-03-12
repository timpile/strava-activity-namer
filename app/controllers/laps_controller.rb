class LapsController < ApplicationController

  def refresh
    @activity = Activity.find(params[:id])
    @laps = current_user.strava_client.list_activity_laps(@activity.strava_id)
    @laps.each do |lap|
      lp = Lap.where(strava_id: lap['id']).first_or_create do |l|
        l.activity = @activity
      end
      lp.update_columns(
        name: lap['name'],
        elapsed_time: lap['elapsed_time'],
        distance: lap['distance'],
        average_speed: lap['average_speed'],
        lap_index: lap['lap_index']
      )
    end
    redirect_to root_url
  end

end

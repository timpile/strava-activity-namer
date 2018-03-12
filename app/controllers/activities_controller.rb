class ActivitiesController < ApplicationController

  def show
    @activity = Activity.includes(:laps).find_by_strava_id(params[:id])
  end

  def refresh
    @activities = current_user.strava_client.list_athlete_activities(after: current_user.last_activity_date, per_page: 50)
    @activities.each do |activity|
      act = Activity.where(strava_id: activity['id']).first_or_create do |a|
        a.user = current_user
        a.name = activity['name']
        a.activity_type = activity['type']
        a.start_date_local = activity['start_date_local']
        a.elapsed_time = activity['elapsed_time']
        a.description = activity['description']
        a.distance = activity['distance']
      end
      @laps = current_user.strava_client.list_activity_laps(act.strava_id)
      @laps.each do |lap|
        Lap.where(strava_id: lap['id']).first_or_create do |l|
          l.activity = act
          l.name = lap['name']
          l.elapsed_time = lap['elapsed_time']
          l.distance = lap['distance']
          l.average_speed = lap['average_speed']
          l.lap_index = lap['lap_index']
        end
      end
    end
    redirect_to root_url
  end

end

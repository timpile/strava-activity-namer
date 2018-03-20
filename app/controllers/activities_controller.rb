class ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.data_set.extend(DescriptiveStatistics).order("strava_id DESC")
  end

  def show
    @activity = Activity.includes(:laps).find_by_strava_id(params[:id])
  end

  def set_name
    @activity = Activity.find(params[:id])
    @activity.user.strava_client.update_an_activity(@activity.strava_id, name: @activity.sentence_generator)
    redirect_to activities_path
  end

  def refresh
    @activities = current_user.strava_client.list_athlete_activities(after: current_user.last_activity_date, per_page: 200)
    @activities.each do |activity|
      act = Activity.where(strava_id: activity['id']).first_or_create do |a|
        a.user = current_user
      end
      act.update_columns(
        name: activity['name'],
        activity_type: activity['type'],
        start_date_local: activity['start_date_local'],
        elapsed_time: activity['elapsed_time'],
        description: activity['description'],
        distance: activity['distance'],
        average_speed: activity['average_speed']
      )
      act.set_distance_percentile_rank!
    end
    redirect_to activities_path
  end

end

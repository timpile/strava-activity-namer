class PagesController < ApplicationController

  def home
    @athlete = current_user.strava_client.retrieve_current_athlete
    @activities = current_user.strava_client.list_athlete_activities(after: 10.days.ago, before: 0.days.ago, per_page: 10)
  end

  def activity
    @activity_laps = current_user.strava_client.list_activity_laps(params[:id])
  end

end

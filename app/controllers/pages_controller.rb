class PagesController < ApplicationController

  def home
    @athlete = current_user.strava_client.retrieve_current_athlete
    @activities = current_user.activities.order("strava_id DESC")
  end

end

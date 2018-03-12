class PagesController < ApplicationController

  def home
    @activities = current_user.activities.data_set.extend(DescriptiveStatistics).order("strava_id DESC")
    @speed_data = current_user.activities.data_analysis("average_speed")
    @distance_data = current_user.activities.data_analysis("distance")
  end

end

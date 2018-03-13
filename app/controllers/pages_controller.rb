class PagesController < ApplicationController

  def home
    @activities = current_user.activities.data_set.extend(DescriptiveStatistics).order("strava_id DESC")
  end

end

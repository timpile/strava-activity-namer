class ActivitiesController < ApplicationController

  def refresh
    puts 'Activity data has been refreshed!!!'
    redirect_to root_url
  end

end

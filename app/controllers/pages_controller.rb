class PagesController < ApplicationController
  before_action :set_client

  def home
    @activities = @client.list_athlete_activities
  end

  def activity
    @activity_laps = @client.list_activity_laps(params[:id])
  end

  private

  def set_client
    @client = Strava::Api::V3::Client.new(:access_token => current_user.token)
  end
end

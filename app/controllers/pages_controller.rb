class PagesController < ApplicationController
  def home
    @client = Strava::Api::V3::Client.new(:access_token => current_user.token) if current_user.token
    @activities = @client.list_athlete_activities if @client
  end
end

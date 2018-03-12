class ActivitiesController < ApplicationController

  def refresh
    @activities = current_user.strava_client.list_athlete_activities(after: current_user.last_activity_date, per_page: 100)
    @activities.each do |activity|
      puts "Activity: #{activity['id']} | #{activity['name']} | #{activity['start_date_local']}"
      Activity.where(strava_id: activity['id']).first_or_create do |a|
        a.user = current_user
        a.name = activity['name']
        a.activity_type = activity['type']
        a.start_date_local = activity['start_date_local']
        a.elapsed_time = activity['elapsed_time']
        a.description = activity['description']
        a.distance = activity['distance']
      end
    end
    redirect_to root_url
  end

end

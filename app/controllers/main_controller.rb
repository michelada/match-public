class MainController < ApplicationController
  def index
    @top_teams = Activity.team_score(6)
    @latest_activities = Activity.latest_activities
  end
end

class MainController < ApplicationController
  def index
    @top_teams = Activity.top_teams_by_score(3)
    @latest_activities = Activity.latest_activities
    @total_score = Activity.total_score
  end
end

class MainController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth

  def check_auth
    redirect_to controller: :landing_page unless user_signed_in?
  end

  def index
    @top_teams = Activity.top_teams_by_score(3)
    @all_teams = Activity.top_teams_by_score(Team.teams_count)
    @latest_activities = Activity.latest_activities
    @total_score = Activity.total_score
  end
end

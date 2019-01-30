class MainController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth
  def check_auth
    unless user_signed_in?
      redirect_to :controller => :landing_page
    end
  end
  def index
    @top_teams = Activity.top_teams_by_score(3)
    @latest_activities = Activity.latest_activities
    @total_score = Activity.total_score
  end
end

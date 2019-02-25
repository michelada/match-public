class MainController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth

  def check_auth
    redirect_to controller: :landing_page unless user_signed_in?
  end

  def index
    user_is_admin
    @all_teams = Activity.top_teams_by_score(Team.teams_count)
    @latest_activities = Activity.latest_activities(3)
    @total_score = Activity.total_score
  end

  private

  def user_is_admin
    redirect_to admin_user_manager_index_path if current_user.role == 'admin'
  end
end

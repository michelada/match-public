class MainController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth

  def check_auth
    redirect_to controller: :landing_page unless user_signed_in?
  end

  def index
    user_is_admin

    @total_score = Activity.total_score
    if Poll.last_ended_poll(DateTime.now).empty?
      # VALIDATE THAT THERE IS NO A MCM VERSION
      @all_teams = Activity.top_teams_by_score(Team.teams_count)
      @last_activities = Activity.latest_activities(3)
    else
      @winner_team = Activity.last_team_winner
      @last_activities = []
      3.times { |i| @last_activities << Activity.best_activities(Poll.last, i) }
    end
  end

  private

  def user_is_admin
    redirect_to admin_user_manager_index_path if current_user.is_admin?
  end
end

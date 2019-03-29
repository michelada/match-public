class MainController < ApplicationController
  before_action :user_is_admin?

  def index
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
end

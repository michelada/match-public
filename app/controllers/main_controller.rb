class MainController < MatchesController
  before_action :user_is_admin?

  def index
    return if Match.active_match.first

    @winner_team = Match.last.leader_team
    @best_activities = []
    3.times { |i| @best_activities << Activity.best_activities(Poll.last, i) }
  end
end

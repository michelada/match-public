class MainController < MatchesController
  before_action :user_is_admin?

  def index
    if Poll.last_ended_poll(DateTime.now).empty?
      @poll = @match.poll
    else
      @winner_team = Match.last.leader_team
      @last_activities = []
      3.times { |i| @last_activities << Activity.best_activities(Poll.last, i) }
    end
  end
end

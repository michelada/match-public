class PollsController < MatchesController
  before_action :user_can_access?

  def show
    @poll = Poll.find(params[:id])
    @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
    @activities_votes = if current_user.judge?
                          Vote.judge_activities_votes(@poll.id)
                        else
                          Vote.user_activities_votes(@poll.id, current_user.id)
                        end
    @activity_types = @activities.group(:activity_type).select(:activity_type)
    @best_activities = []
    3.times { |i| @best_activities << Activity.best_activities(@poll.id, i) }
    return unless @activities.empty?

    flash[:alert] = t('poll.empty_activities')
    redirect_to match_main_index_path(@match)
  end

  def user_can_access?
    return unless Poll.users_can_vote(Time.now.in_time_zone('Mexico City').to_date).empty?

    flash[:alert] = t('poll.error_accesing')
    redirect_to match_main_index_path(@match)
  end
end

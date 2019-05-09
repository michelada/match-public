class VotesController < MatchesController
  before_action :user_can_vote?, only: [:create]

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = t('votes.voted')
    else
      flash[:alert] = t('votes.error_voting')
    end
    redirect_to match_poll_path(@match, params[:poll_id])
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      flash[:notice] = t('votes.unvoted')
    else
      flash[:alert] = t('votes.error_unvoting')
    end
    redirect_to match_poll_path(@match, params[:poll_id])
  end

  private

  def vote_params
    activity = Activity.friendly.find(params[:activity_id])
    params.permit(:poll_id).merge(activity_id: activity.id,
                                  user_id: current_user.id,
                                  value: 10)
  end

  def user_can_vote?
    poll = Poll.find_by(id: params[:poll_id])
    activity = Activity.friendly.find(params[:activity_id])
    return unless poll.voted_for_type?(activity, current_user)

    flash[:alert] = t('votes.error_type')
    redirect_to match_poll_path(@match, parmas[:poll_id])
  end
end

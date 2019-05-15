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
    content = if @match.content_match?
                Activity.friendly.find(params[:content_id])
              else
                Project.friendly.find(params[:content_id])
              end
    value = current_user.judge? ? 50 : 10
    params.permit(:poll_id).merge(content_id: content.id,
                                  user_id: current_user.id,
                                  value: value,
                                  content_type: content.class)
  end

  def user_can_vote?
    poll = Poll.find(params[:poll_id])
    if @match.content_match?
      activity = Activity.friendly.find(params[:content_id])
      return unless poll.voted_for_activity_type?(activity, current_user)

      flash[:alert] = t('votes.error_type')
    else
      return unless poll.user_has_voted?(current_user)

      flash[:alert] = t('poll.user_has_voted')
    end
    redirect_to match_poll_path(@match, params[:poll_id])
  end
end

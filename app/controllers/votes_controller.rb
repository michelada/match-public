class VotesController < ApplicationController
  def create
    assign_vote_value
    if user_can_vote
      if @vote.save
        flash[:notice] = t('votes.voted')
      else
        flash[:alert] = t('votes.error_voting')
      end
    end
    redirect_to polls_path
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.destroy
      flash[:notice] = t('votes.unvoted')
    else
      flash[:alert] = t('votes.error_unvoting')
    end
    redirect_to polls_path
  end

  private

  def assign_vote_value
    @vote = Vote.new
    @vote.poll_id = params[:poll_id]
    @vote.activity_id = params[:activity_id]
    @vote.user_id = current_user.id
    @vote.value = 10
  end

  def user_can_vote
    activity_type = Activity.type_of_activity(params[:activity_id])
    user_has_voted = Vote.has_voted_for_type(current_user.id, activity_type.first.type)
    return true if user_has_voted.empty?

    flash[:alert] = t('votes.error_type')
    false
  end
end

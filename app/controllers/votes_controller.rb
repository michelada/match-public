class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.poll_id = params[:poll_id]
    @vote.activity_id = params[:activity_id]
    @vote.user_id = current_user.id
    if user_can_vote
      if @vote.save
        assign_points(true)
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
      assign_points(false)
      flash[:notice] = t('votes.unvoted')
    else
      flash[:alert] = t('votes.error_unvoting')
    end
    redirect_to polls_path
  end

  private

  def assign_points(add_points)
    extra_points = add_points ? 10 : -10
    activity = Activity.find(params[:activity_id])
    activity.score = activity.score + extra_points
    activity.update_attributes(score: activity.score)
  end

  def user_can_vote
    activity_type = Activity.type_of_activity(params[:activity_id])
    user_has_voted = Vote.has_voted_for_type(current_user.id, activity_type.first.type)
    return true if user_has_voted.empty?

    flash[:alert] = t('votes.error_type')
    false
  end
end

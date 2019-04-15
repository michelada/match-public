module Judge
  class VotesController < ApplicationController
    before_action :user_can_vote?, only: [:create]

    def create
      @vote = Vote.new(vote_params)
      if @vote.save
        flash[:notice] = t('votes.voted')
      else
        flash[:alert] = t('votes.error_voting')
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

    def vote_params
      activity = Activity.friendly.find(params[:activity_id])
      params.permit(:poll_id).merge(activity_id: activity.id,
                                    user_id: current_user.id,
                                    value: 50)
    end

    def user_can_vote?
      poll = Poll.find_by(id: params[:poll_id])
      activity = Activity.friendly.find(params[:activity_id])
      return unless poll.voted_for_type?(activity, current_user)

      flash[:alert] = t('votes.error_type')
      redirect_to polls_path

      # activity_type = Activity.type_of_activity(params[:activity_id])
      # user_has_voted = Vote.judge_has_voted_for_type(activity_type.first.type)
      # return true if user_has_voted.empty?
    end
  end
end

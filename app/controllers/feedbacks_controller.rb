class FeedbacksController < ApplicationController
  before_action :load_activity
  def create
    @comment = Feedback.new(feedback_params)
    @comment.user_id = current_user.id
    @comment.activity_id = @activity.id
    if @comment.save
      flash[:notice] = t('comments.created')
    else
      flash[:alert] = t('comments.error_creating')
    end
    redirect_to activity_path(@activity)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment)
  end

  def load_activity
    @activity = Activity.find(params[:activity_id])
  end
end

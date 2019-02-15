class FeedbacksController < ApplicationController
  before_action :load_activity
  def create
    generate_comment
    if @comment.save
      flash[:notice] = t('comments.created')
    else
      flash[:alert] = t('comments.error_creating')
    end
    redirect_to activity_path(@activity)
  end

  def update
    @feedback = Feedback.find_by(id: params[:id])
    if @feedback.update_attributes(comment: params[:comment])
      flash[:notice] = t('activities.messages.updated')
      redirect_to activity_path(@feedback.activity)
    else
      flash[:alert] = t('alerts.activities.not_black')
      redirect_to activity_path(@feedback.activity)
    end
  end

  def destroy
    @feedback = Feedback.find_by(id: params[:activity_id])
    if @feedback.destroy
      flash[:notice] = t('activities.messages.deleted')
      redirect_to activity_path(@feedback.activity)
    else
      flash[:alert] = t('activities.messagess.error_deleting')
      redirect_to activity_path(@feedback.activity)
    end
  end

  private

  def generate_comment
    @comment = Feedback.new(feedback_params)
    @comment.user_id = current_user.id
    @comment.activity_id = @activity.id
  end

  def feedback_params
    params.require(:feedback).permit(:comment)
  end

  def load_activity
    @activity = Activity.find(params[:activity_id])
  end
end

class FeedbacksController < MatchesController
  before_action :load_commentable, only: [:create, :update]
  def create
    @comment = Feedback.new(feedback_params)
    if @comment.save
      flash[:notice] = t('comments.created')
    else
      flash[:alert] = t('comments.error_creating')
    end
    redirect_to @commentable_path
  end

  def update
    @feedback = Feedback.find_by(id: params[:id])
    if @feedback.update_attributes(feedback_params)
      flash[:notice] = t('activities.messages.feedback_updated')
    else
      flash[:alert] = t('alerts.activities.not_black')
    end
    redirect_to @commentable_path
  end

  private

  def feedback_params
    params.require(:feedback)
          .permit(:comment, :file)
          .merge(user_id: current_user.id,
                 commentable: @commentable)
  end

  def load_commentable
    if params[:activity_id].present?
      @commentable = Activity.friendly.find(params[:activity_id])
      @commentable_path = match_activity_path(@match, @commentable)
    elsif params[:project_id].present?
      @commentable = Project.friendly.find(params[:project_id])
      @commentable_path = match_project_path(@match, @commentable)
    end
  end
end

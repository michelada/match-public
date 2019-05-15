module Judge
  class ActivityStatusController < JudgeController
    before_action :load_status
    def create
      @content.statuses.build(user_id: current_user.id, approve: true)
      if @content.save
        flash[:notice] = t('activities.messages.approved')
      else
        flash[:alert] = t('activities.messages.error_approving')
      end
      redirect_to @content_path
    end

    def destroy
      @content_status = ActivityStatus.user_approve_status_activity(current_user.id, @content.id)
      if @content_status.destroy
        flash[:notice] = t('activities.messages.unapproved')
      else
        flash[:alert] = t('activities.messages.error_unapproving')
      end

      redirect_to @content_path
    end

    private

    def activity_status_params
      params.permit(:activity_id)
    end

    def load_status
      if params[:activity_id].present?
        @content = Activity.friendly.find(params[:activity_id])
        @content_path = match_activity_path(@match, @content)
      elsif params[:project_id].present?
        @content = Project.friendly.find(params[:project_id])
        @content_path = match_project_path(@match, @content)
      end
    end
  end
end

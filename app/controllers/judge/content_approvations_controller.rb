module Judge
  class ContentApprovationsController < JudgeController
    before_action :load_status
    def create
      @content.approvations.build(user_id: current_user.id, approve: true)
      if @content.save
        flash[:notice] = if @content.class == Activity
                           t('activities.messages.approved')
                         else
                           t('projects.messages.approved')
                         end
      else
        flash[:alert] = if @content.class == Activity
                          t('activities.messages.error_approving')
                        else
                          t('projects.messages.error_approving')
                        end
      end
      redirect_to @content_path
    end

    def destroy
      content_status = ActivityStatus.find(params[:id])
      if content_status.destroy
        flash[:notice] = if @content.class == Activity
                           t('activities.messages.unapproved')
                         else
                           t('projects.messages.unapproved')
                         end
      else
        flash[:alert] = if @content.class == Activity
                          t('activities.messages.error_unapproving')
                        else
                          t('projects.messages.error_unapproving')
                        end
      end
      redirect_to @content_path
    end

    private

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

module Judge
  class ActivityStatusController < JudgeController
    before_action :load_status, except: [:index, :new]
    def create
      @item.statuses.build(user_id: current_user.id, approve: true)
      if @item.save
        flash[:notice] = t('activities.messages.approved')
      else
        flash[:alert] = t('activities.messages.error_approving')
      end
      redirect_to @item_path
    end

    def destroy
      @item_status = ActivityStatus.user_approve_status_activity(current_user.id, @item.id)
      if @item_status.destroy
        flash[:notice] = t('activities.messages.unapproved')
      else
        flash[:alert] = t('activities.messages.error_unapproving')
      end

      redirect_to @item_path
    end

    private

    def activity_status_params
      params.permit(:activity_id)
    end

    def load_status
      if params[:activity_id].present?
        @item = Activity.friendly.find(params[:activity_id])
        @item_path = match_activity_path(@match, @item)
      elsif params[:project_id].present?
        @item = Project.friendly.find(params[:project_id])
        @item_path = match_project_path(@match, @item)
      end
    end
  end
end

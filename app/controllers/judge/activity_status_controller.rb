module Judge
  class ActivityStatusController < JudgeController
    def create
      @activity_status = ActivityStatus.new(activity_status_params)
      @activity_status.user_id = current_user.id
      @activity_status.approve = true
      if @activity_status.save && verify_activity_general_status
        flash[:notice] = t('activities.messages.approved')
      else
        flash[:alert] = t('activities.messages.error_approving')
      end
      redirect_to judge_activity_path(@activity_status.activity_id)
    end

    def destroy
      @activity_status = ActivityStatus.user_approve_status_activity(current_user.id, params[:activity_id])
      if @activity_status.destroy && verify_activity_general_status
        flash[:notice] = t('activities.messages.unapproved')
      else
        flash[:alert] = t('activities.messages.error_unapproving')
      end

      redirect_to judge_activity_path(@activity_status.activity_id)
    end

    private

    def activity_status_params
      params.permit(:activity_id)
    end

    def verify_activity_general_status
      activity_statuses = ActivityStatus.approves_in_activity(params[:activity_id])
      activity = Activity.find(params[:activity_id])
      if activity_statuses.count == 3
        activity.update_attribute(:status, 2)
      else
        activity.update_attribute(:status, 1)
      end
    end
  end
end

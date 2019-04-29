module Judge
  class ActivityStatusController < JudgeController
    def create
      @activity_status = activity.activity_statuses.build(user_id: current_user.id, approve: true)
      if @activity_status.save
        flash[:notice] = t('activities.messages.approved')
      else
        flash[:alert] = t('activities.messages.error_approving')
      end
      redirect_to match_judge_activity_path(@match, activity)
    end

    def destroy
      @activity_status = ActivityStatus.user_approve_status_activity(current_user.id, activity.id)
      if @activity_status.destroy
        flash[:notice] = t('activities.messages.unapproved')
      else
        flash[:alert] = t('activities.messages.error_unapproving')
      end

      redirect_to match_judge_activity_path(@match, activity)
    end

    private

    def activity_status_params
      params.permit(:activity_id)
    end

    def activity
      @activity ||= Activity.friendly.find(params[:activity_id])
    end
  end
end

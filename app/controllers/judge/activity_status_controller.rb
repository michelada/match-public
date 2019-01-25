module Judge
  class ActivityStatusController < ApplicationController
    def create
      @activity_status = ActivityStatus.new(activity_status_params)
      @activity_status.user_id = current_user.id
      @activity_status.aprove = true
      if @activity_status.save && verify_activity_general_status
        flash[:notice] = t('activities.messages.aproved')
      else
        flash[:alert] = t('activities.messages.error_aproving')
      end
      redirect_to judge_activity_path(@activity_status.activity_id)
    end

    def update
      change_activity_status
      if @activity_status.update_attribute(:aprove, @activity_status.aprove) && verify_activity_general_status
        flash[:notice] = @activity_status.aprove ? t('activities.messages.aproved') : t('activities.messages.unaproved')
      else
        flash[:alert] = @activity_status.aprove ? t('activities.messages.error_aproving') : t('activities.messages.error_unaproving')
      end
      redirect_to judge_activity_path(@activity_status.activity_id)
    end

    private

    def change_activity_status
      @activity_status = ActivityStatus.user_aprove_status_activity(current_user.id, params[:activity_id])
      @activity_status.aprove = !@activity_status.aprove
    end

    def activity_status_params
      params.permit(:activity_id)
    end

    def verify_activity_general_status
      activity_statuses = ActivityStatus.aproves_in_activity(params[:activity_id])
      activity = Activity.find(params[:activity_id])
      if activity_statuses.count == 3
        activity.update_attribute(:status, 2)
      else
        activity.update_attribute(:status, 1)
      end
    end
  end
end

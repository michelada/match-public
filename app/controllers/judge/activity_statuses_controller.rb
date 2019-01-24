module Judge
  class ActivityStatusesController < ApplicationController
    def create
      @activity_status = ActivityStatus.new(activity_status_params)
      @activity_status.user_id = current_user.id
      @activity_status.aprove = true
      if @activity_status.save
        flash[:notice] = t('activities.messajes.aproved')
      else
        flash[:alert] = t('activities.messajes.error_aproving')
      end
      redirect_to judge_activity_path(@activity_status.activity_id)
    end

    def update
      change_activity_status
      if @activity_status.update_attribute(:aprove, @activity_status.aprove)
        flash[:notice] = @activity_status.aprove ? t('activities.messajes.aproved') : t('activities.messajes.unaproved')
      else
        flash[:alert] = @activity_status.aprove ? t('activities.messajes.error_aproving') : t('activities.messajes.error_unaproving')
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
  end
end

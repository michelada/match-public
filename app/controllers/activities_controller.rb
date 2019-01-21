class ActivitiesController < ApplicationController
  def index
    @activities = Activity.user_activities(current_user.id)
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    if @activity.save
      redirect_to activities_path
      flash[:notice] = t('activities.messajes.uploaded')
    else
      flash[:alert] = t('activities.messajes.error_uploading')
      render 'new'
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :english, :location)
  end
end

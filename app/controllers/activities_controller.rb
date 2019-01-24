class ActivitiesController < ApplicationController
  def index
    @activities = Activity.user_activities(current_user.id)

    @last_activity = Activity.last
    
    respond_to do |format|
      format.html
      format.json { render json: @last_activity }
    end
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

  def destroy
    @activity = Activity.find_by(id: params[:id])
    if @activity.destroy
      flash[:notice] = t('activities.messajes.deleted')
      redirect_to activities_path
    else
      flash[:alert] = t('activities.messajess.erorr_deleting')
      render 'index'
    end
  end

  def edit
    @activity = Activity.find_by(id: params[:id])
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    if @activity.update(activity_params)
      flash[:notice] = t('activities.messajes.updated')
      redirect_to activities_path
    else
      flash[:notice] = t('activities.messajes.error_updatind')
      render 'edit'
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :english, :location, :activity_type)
  end

  end
end
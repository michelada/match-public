class ActivitiesController < ApplicationController
  def index
    @activities = Activity.user_activities(current_user.id)
  end

  def new
    @activity = Activity.new
    @feedback = Feedback.new
    @locations = Location.all
    @selected_locations = []
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    if @activity.save
      assign_locations_string
      redirect_to activities_path
      flash[:notice] = t('activities.messages.uploaded')
    else
      flash[:alert] = t('activities.messages.error_uploading')
      render 'new'
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @feedback = Feedback.new
  end

  def destroy
    @activity = Activity.find_by(id: params[:id])
    if @activity.destroy
      flash[:notice] = t('activities.messages.deleted')
      redirect_to activities_path
    else
      flash[:alert] = t('activities.messagess.erorr_deleting')
      render 'index'
    end
  end

  def edit
    @activity = Activity.find_by(id: params[:id])
    @locations = Location.all
    @selected_locations = @activity.locations
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    if @activity.update(activity_params)
      @activity.locations = []
      assign_locations_string
      flash[:notice] = t('activities.messages.updated')
      redirect_to activities_path
    else
      flash[:notice] = t('activities.messages.error_updatind')
      render 'edit'
    end
  end

  private

  def assign_locations_string
    @selected_locations = params[:locations_string].split(',')
    @selected_locations.each do |location_name|
      if Location.exists?(['name LIKE ?', location_name.to_s])
        @activity.locations << Location.find_by(name: location_name)
      else
        new_location = Location.create(name: location_name)
        @activity.locations << new_location
      end
    end
  end

  def activity_params
    params.require(:activity).permit(:name, :english, :location, :activity_type)
  end
end

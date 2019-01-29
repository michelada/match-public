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
    @locations = Location.all
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    if @activity.save && assign_locations_string && assign_activity_points
      redirect_to activities_path
      flash[:notice] = t('activities.messages.uploaded')
    else
      flash[:alert] = t('activities.messages.error_creating')
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
      flash[:notice] = t('activities.messages.error_updating')
      render 'edit'
    end
  end

  private

  def assign_locations_string
    @selected_locations = params[:locations_string]
    return true if @selected_locations.empty?

    check_if_exists_and_assing
  end

  def check_if_exists_and_assing
    @selected_locations.split('ß').each do |location_name|
      location_name[0] = location_name[0].upcase
      @activity.locations << if Location.exists?(['name ILIKE ?', location_name.to_s])
                               Location.where('name ILIKE ?', location_name)
                             else
                               Location.create(name: location_name)
                             end
    end
  end

  def assign_activity_points
    obtain_activity_points
    @activity.update_attribute(:score, @activity.score)
  end

  def obtain_activity_points
    @activity.score = 40 if @activity.activity_type == 'Curso'
    @activity.score = 25 if @activity.activity_type == 'Platica'
    @activity.score = 10 if @activity.activity_type == 'Post'
    @activity.score += 5 if @activity.english
    events_extra_points = @activity.activity_type == 'Post' ? 5 : 15
    @activity.score += events_extra_points * @activity.locations.count
  end

  def activity_params
    params.require(:activity).permit(:name, :english, :location, :activity_type, :locations_string)
  end
end

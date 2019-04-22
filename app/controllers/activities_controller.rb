class ActivitiesController < MatchesController
  before_action :user_can_edit_activity?, only: [:edit, :update, :destroy]
  before_action :user_can_upload_activity?, only: [:new, :create]

  def new
    @activity = Activity.new
    @activity.locations.build
    @feedback = Feedback.new
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      flash[:notice] = t('activities.messages.uploaded')
      redirect_to match_team_path(params[:match_id], current_user.team)
    else
      @activity.locations.build if @activity.locations.blank?
      flash.now[:alert] = t('activities.messages.error_creating')
      render 'new'
    end
  end

  def show
    @activity = Activity.friendly.find(params[:id])
    @feedback = Feedback.new
  end

  def destroy
    activity = Activity.friendly.find(params[:id])
    if !activity.approved? && activity.destroy
      flash[:notice] = t('activities.messages.deleted')
    else
      flash[:alert] = t('activities.messages.error_deleting')
    end
    redirect_to match_team_path(params[:match_id], current_user.team)
  end

  def edit
    @activity = Activity.friendly.find(params[:id])
  end

  def update
    @activity = Activity.friendly.find(params[:id])
    # assign_score
    if @activity.update(activity_params)
      flash[:notice] = t('activities.messages.updated')
      redirect_to match_team_path(params[:match_id], current_user.team)
    else
      flash.now[:alert] = t('alerts.activities.not_black')
      render 'edit'
    end
  end

  private

  def activity_params
    params.require(:activity)
          .permit(:name, :english,
                  :activity_type,
                  :description, :pitch_audience,
                  :abstract_outline, :notes,
                  :file,
                  locations_attributes: [:name, :id, :_destroy])
          .merge(match_id: params[:match_id], user: current_user)
  end
end

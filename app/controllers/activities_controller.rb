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
      redirect_to match_team_path(params[:match_id], current_user.current_team)
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
    redirect_to match_team_path(params[:match_id], current_user.current_team)
  end

  def edit
    @activity = Activity.friendly.find(params[:id])
  end

  def update
    @activity = Activity.friendly.find(params[:id])
    if @activity.update(activity_params)
      flash[:notice] = t('activities.messages.updated')
      redirect_to match_team_path(params[:match_id], current_user.current_team)
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
                  files: [],
                  locations_attributes: [:name, :id, :_destroy])
          .merge(match_id: params[:match_id], user: current_user)
  end

  def user_can_edit_activity?
    activity = Activity.friendly.find(params[:id])
    return unless activity.approved?

    flash[:alert] = t('activities.messages.error_accessing')
    redirect_to root_path
  end

  def user_can_upload_activity?
    match = Match.find(params[:match_id])
    if match.content_match?
      if current_user.current_team
        return if match.active?

        flash[:alert] = t('activities.closed')
        redirect_to match_main_index_path(@match)
      else
        flash[:alert] = t('projects.no_team')
        redirect_to new_match_team_path(@match)
      end
    else
      flash[:alert] = t('match.error_type')
      redirect_to root_path
    end
  end
end

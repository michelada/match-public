# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_users)
    if current_user.team? && !current_user.admin?
      new_team_path
    else
      redirect_user
    end
  end

  def redirect_user
    if current_user.judge?
      judge_main_index_path
    else
      current_user.admin? ? admin_user_manager_index_path : new_activity_path
    end
  end

  def user_is_admin?
    redirect_to root_path if current_user.admin?
  end

  def user_has_permission?
    return if current_user.part_of_team?(params[:id])

    flash[:alert] = t('team.error_accessing')
    redirect_to root_path
  end

  def user_can_edit_activity?
    activity = Activity.friendly.find(params[:id])
    return unless activity.approved?

    flash[:alert] = t('activities.messages.error_accessing')
    redirect_to root_path
  end

  def user_can_upload_activity?
    if current_user.team.nil?
      redirect_to new_team_path
    else
      actual_date = DateTime.now.in_time_zone('Mexico City')
      limit_date = Poll.last&.end_date
      return if  !Poll.last || actual_date < limit_date

      flash[:alert] = t('activities.closed')
      redirect_to main_index_path
    end
  end
end

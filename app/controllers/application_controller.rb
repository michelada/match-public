# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!
  before_action :set_match

  def after_sign_in_path_for(_users)
    if current_user.team? && !current_user.admin?
      new_match_team_path(Match.last)
    else
      redirect_user
    end
  end

  def redirect_user
    if current_user.judge?
      match_judge_main_index_path(Match.last)
    else
      current_user.admin? ? admin_user_manager_index_path : new_match_activity_path(Match.last)
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
      redirect_to new_match_team_path(@match)
    else
      actual_date = DateTime.now.in_time_zone('Mexico City')
      limit_date = Match.last&.end_date
      start_date = Match.last&.start_date

      return if Match.last && (start_date..limit_date).cover?(actual_date)

      flash[:alert] = t('activities.closed')
      redirect_to match_main_index_path(@match)
    end
  end

  def user_can_upload_project?
    if current_user.team.nil?
      flash[:alert] = t('projects.no_team')
      redirect_to new_match_team_path(@match)
    elsif current_user.project.present?
      flash[:alert] = t('projects.already_have_one')
      redirect_to match_team_path(@match, current_user.team)
    end
  end

  def set_match
    @match = Match.last
  end
end

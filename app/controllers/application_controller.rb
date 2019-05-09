# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!
  before_action :set_match

  def after_sign_in_path_for(_users)
    if current_user.current_team && !current_user.admin?
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

  def set_match
    @match = Match.last
  end
end

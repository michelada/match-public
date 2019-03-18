# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_users)
    if current_user.has_team? && !current_user.is_admin?
      new_team_path
    else
      redirect_user
    end
  end

  def redirect_user
    if current_user.is_judge?
      judge_main_index_path
    else
      current_user.is_admin? ? admin_user_manager_index_path : new_activity_path
    end
  end
end

# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_users)
    if current_user.team.nil? && current_user.role != 'admin'
      new_team_path
    else
      redirect_user
    end
  end

  def redirect_user
    if current_user.role == 'judge'
      judge_main_index_path
    else
      current_user.role == 'admin' ? admin_user_manager_index_path : new_activity_path
    end
  end
end

# Main controller
class ApplicationController < ::ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_users)
    if current_user.team.nil?
      new_team_path
    else
      main_index_path
    end
  end
end

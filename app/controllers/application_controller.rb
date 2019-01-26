# Main controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(users)
    if current_user.team.nil?
      new_team_path 
    else
      root_path
    end
  end

end

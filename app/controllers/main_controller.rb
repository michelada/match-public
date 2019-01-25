class MainController < ApplicationController
  def index
    @current_user = current_user
    redirect_to new_team_path if @current_user.team.nil?
  end
end

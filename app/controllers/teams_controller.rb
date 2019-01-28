class TeamsController < ApplicationController
  before_action :user_has_team
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save && current_user.update_attribute(:team, @team)
      flash[:notice] = t('team.messages.created')
      redirect_to root_path
    else
      flash[:alert] = t('team.messages.error_creating')
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def user_has_team
    redirect_to root_path if current_user.team
  end
end

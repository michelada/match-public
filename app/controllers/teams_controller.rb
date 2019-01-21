class TeamsController < ApplicationController
  before_action :authenticate_user!
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save && current_user.update_attribute(:team, @team)
      flash[:notice] = t('team.messajes.created')
      redirect_to root_path
    else
      flash[:alert] = t('team.messajes.error_creating')
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end

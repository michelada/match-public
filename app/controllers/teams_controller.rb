class TeamsController < ApplicationController
  def new
    redirect_to team_path(current_user.team) unless current_user.team.nil?
    @team = Team.new
    @name = "#{Spicy::Proton.adjective}_#{Spicy::Proton.noun}"
  end

  def create
    @team = Team.new(team_params)
    if @team.save && current_user.update_attribute(:team, @team)
      flash[:notice] = t('team.messages.created')
      redirect_to root_path
    else
      flash[:alert] = t('team.messages.error_creating')
      render new_team_path
    end
  end

  def show
    @team = Team.find_by(id: params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end

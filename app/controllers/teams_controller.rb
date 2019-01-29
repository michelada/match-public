class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save && current_user.update_attribute(:team, @team)
      flash[:notice] = t('team.messages.created')
      redirect_to main_index_path
    else
      flash[:alert] = t('team.messages.error_creating')
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end

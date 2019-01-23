class TeamsController < ApplicationController

  def index
    @top_trhee_teams = Team.obtain_top_three_teams
    respond_to do |format|
      format.html
      format.json { render json: @top_trhee_teams}
    end
  end

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

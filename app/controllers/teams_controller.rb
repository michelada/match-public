class TeamsController < ApplicationController

  def index
    @top_three_teams = Team.obtain_top_three_teams
    @response = create_format(@top_three_teams)
    respond_to do |format|
      format.html
      format.json { render json: @response}
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

  def create_format(teams)
    base_obj = {
      "postfix": "Top 3 Teams",
      "color": "green",
      "data": [
          {
              "name":"Sunday",
              "value": 1450
          },
          {
              "name":"Sunday",
              "value": 1450
          }
       ]
    }
   
    response = base_obj.clone
    response["data"] = []
    teams.each do |team|
      response["data"].push({
        name: team.name,
        value: team.score
      })
    end
    return response.to_json
  end
  
end

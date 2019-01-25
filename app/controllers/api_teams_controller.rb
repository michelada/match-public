class ApiTeamsController < ActionController::Base
  def index
    @top_three_teams = Team.obtain_top_three_teams
    @response = ::Api::ApiService.new.top_teams_format(@top_three_teams)
    respond_to do |format|
      format.html
      format.json { render json: @response}
    end
  end
end

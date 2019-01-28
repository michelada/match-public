module Api
  class TeamsController < ::ActionController::Base
    def index
      @top_five_teams = Team.obtain_top_five_teams
      @response = ::Api::ApiService.new.top_teams_format(@top_five_teams)
      render json: @response
    end
  end
end

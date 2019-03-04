module Api
  class TeamsController < ::ActionController::Base
    def index
      @top_five_teams = Activity.top_teams_by_score(5)
      @response = ::Api::ApiService.new.top_teams_format(@top_five_teams)
      render json: @response
    end

    def api
      @winner_team = Activity.top_teams_by_score(1)
      @response = ::Api::ApiService.new.winner_team(@winner_team)
      render json: @response
    end
  end
end

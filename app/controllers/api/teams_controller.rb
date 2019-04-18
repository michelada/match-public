module Api
  class TeamsController < ::ActionController::Base
    def index
      if Poll.last.can_vote?
        @top_five_teams = Poll.last.teams_by_score.limit(5)
        @response = ::Api::ApiService.new.top_teams_format(@top_five_teams)
        render json: @response
      else
        api
      end
    end

    def api
      @winner_team = Poll.last.winner_team
      @response = ::Api::ApiService.new.winner_team(@winner_team)
      render json: @response
    end
  end
end

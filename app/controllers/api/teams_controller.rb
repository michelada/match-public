module Api
  class TeamsController < ::ActionController::Base
    def index
      if Poll.last.can_vote?
        @top_five_teams = Activity.top_teams_by_score(5)
        @response = ::Api::ApiService.new.top_teams_format(@top_five_teams)
        render json: @response
      else
        api
      end
    end

    def api
      @winner_team = Activity.last_team_winner
      @response = ::Api::ApiService.new.winner_team(@winner_team)
      render json: @response
    end
  end
end

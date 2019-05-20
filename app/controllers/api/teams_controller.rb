module Api
  class TeamsController < ::ActionController::Base
    def index
      Match.last.active? ? top_five_teams : winner_team
    end

    private

    def top_five_teams
      type = Match.last.content_match? ? 'Content' : 'Project'
      top_five_teams = Match.where(match_type: type).last.teams_by_score.first(5)
      response = ::Api::ApiService.new.top_teams_format(top_five_teams)
      render json: response
    end

    def winner_team
      winner_team = Match.last&.winner_team
      response = ::Api::ApiService.new.winner_team(winner_team)
      render json: response
    end
  end
end

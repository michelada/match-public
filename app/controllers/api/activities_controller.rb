module Api
  class ActivitiesController < ::ActionController::Base
    def index
      if Poll.users_can_vote(Time.now.in_time_zone('Mexico City').to_date).empty?
        @last_activity = Activity.last
        @response = ::Api::ApiService.new.last_activity_format(@last_activity)
        render json: @response
      else
        api
      end
    end

    def api
      @winner_team = Activity.last_team_winner(Poll.last)
      @response = ::Api::ApiService.new.winner_team(@winner_team)
      render json: @response
    end
  end
end

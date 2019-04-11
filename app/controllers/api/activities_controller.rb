module Api
  class ActivitiesController < ::ActionController::Base
    def index
      if Poll.last.can_vote?
        @last_activity = Activity.last
        @response = ::Api::ApiService.new.last_activity_format(@last_activity)
        render json: @response
      else
        api
      end
    end

    def api
      @best_activities = []
      3.times { |i| @best_activities << Activity.best_activities(Poll.last, i) }
      @response = ::Api::ApiService.new.top_activities_format(@best_activities)
      render json: @response
    end
  end
end

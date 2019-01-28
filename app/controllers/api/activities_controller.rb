module Api
  class ActivitiesController < ::ActionController::Base
    def index
      @last_activity = Activity.last
      @response = ::Api::ApiService.new.last_activity_format(@last_activity)
      render json: @response
    end
  end
end

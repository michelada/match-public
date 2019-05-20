module Api
  class ActivitiesController < ::ActionController::Base
    def index
      return project_match_message unless Match.last.content_match?

      Match.last.active? ? last_activity : best_three_activities
    end

    def last_activity
      last_activity = Activity.last
      response = ::Api::ApiService.new.last_activity_format(last_activity)
      render json: response
    end

    def best_three_activities
      best_activities = []
      3.times { |i| best_activities << Activity.best_activities(Poll.last, i) }
      response = ::Api::ApiService.new.top_activities_format(best_activities)
      render json: response
    end

    def project_match_message
      response = ::Api::ApiService.new.project_match_message
      render json: response
    end
  end
end

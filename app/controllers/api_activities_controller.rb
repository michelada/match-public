class ApiActivitiesController < ActionController::Base
  def index
    @last_activity = Activity.last
    @response = ::Api::ApiService.new.last_activity_format(@last_activity)
    respond_to do |format|
      format.html
      format.json { render json: @response }
    end
  end
end

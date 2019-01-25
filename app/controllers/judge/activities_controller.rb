module Judge
  class ActivitiesController < JudgeController
    def index
      @activities = Activity.all
    end

    def show
      @activity = Activity.find(params[:id])
      @activity_status = @activity.activity_statuses.find_by(user_id: current_user.id)
      @feedback = Feedback.new
    end
  end
end

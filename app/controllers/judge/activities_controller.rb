module Judge
  class ActivitiesController < JudgeController
    def index
      @activities = Activity.all
    end

    def show
      @activity = Activity.find(params[:id])
      @feedback = feedback.find_by(id: params[:id])
    end
  end
end

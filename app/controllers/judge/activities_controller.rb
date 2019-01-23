module Judge
  class ActivitiesController < JudgeController
    def index
      @activities = Activity.all
    end

    def show
      @activity = Activity.find(params[:id])
    end
  end
end

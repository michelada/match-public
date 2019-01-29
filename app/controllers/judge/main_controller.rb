module Judge
  class MainController < JudgeController
    def index
      @activities = Activity.pending_activities(current_user.id)
    end
  end
end

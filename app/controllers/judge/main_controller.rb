module Judge
  class MainController < JudgeController
    def index
      @activities = Activity.unapproved(current_user) || Activity.pending_activities(current_user.id)
    end
  end
end

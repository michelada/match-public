module Judge
  class MainController < JudgeController
    def index
      @on_hold_activities = Activity.all.where(status: 0)
      @pending_activities = Activity.all.where(status: 1)
      @all_activities = Activity.all.order_by_name
    end
  end
end

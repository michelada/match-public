module Judge
  class MainController < JudgeController
    def index
      @match.content_match? ? initialize_activities : initialize_projects
    end

    private

    def initialize_activities
      @on_hold_items = @match.activities.where(status: 0).sort_by_creation
      @pending_items = @match.activities.where(status: 1).sort_by_creation
      @all_items = @match.activities.order_by_name
    end

    def initialize_projects
      @on_hold_items = @match.projects.where(status: 0)
      @all_items = @match.projects
    end
  end
end

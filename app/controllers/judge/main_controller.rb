module Judge
  class MainController < JudgeController
    def index
      @match.content_match? ? initialize_activities : initialize_projects
    end

    private

    def initialize_activities
      @on_hold_contents = @match.activities.where(status: 0).sort_by_creation
      @pending_contents = @match.activities.where(status: 1).sort_by_creation
      @all_content = @match.activities.order_by_name
    end

    def initialize_projects
      @on_hold_contents = @match.projects.where(status: 0)
      @all_content = @match.projects.order_by_name
    end
  end
end

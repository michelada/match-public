module Judge
  class ActivitiesController < JudgeController
    def index
      @activities = Activity.all.order_by_name
    end

    def show
      @activity = Activity.find(params[:id])
      @activity_status = @activity.activity_statuses.find_by(user_id: current_user.id)
      @feedback = Feedback.new
    end

    def update
      @activity = Activity.find(params[:id])
      @activity.update_attributes(english_approve: !@activity.english_approve)
      update_activity_score
      redirect_to judge_activity_path(@activity)
    end

    private

    def update_activity_score
      score = @activity.english_approve ? 5 : -5
      @activity.score = @activity.score + score
      @activity.update_attributes(score: @activity.score)
    end
  end
end

module Judge
  class ActivitiesController < JudgeController
    def index
      @activities = Activity.all.order_by_name
    end

    def show
      @activity = Activity.friendly.find(params[:id])
      @activity_status = @activity.activity_statuses.find_by(user_id: current_user.id)
      @feedback = Feedback.new
    end

    def update
      @activity = Activity.find(params[:id])
      @activity.update_attributes(english_approve: !@activity.english_approve)
      message = @activity.english_approve ? t('labels.approved') : t('labels.unapproved')
      flash[:notice] = message
      redirect_to judge_activity_path(@activity)
    end
  end
end

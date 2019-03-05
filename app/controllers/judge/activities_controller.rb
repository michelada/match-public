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
      message = @activity.english_approve ? t('labels.approved') : t('labels.unapproved')
      flash[:notice] = message
      update_activity_score
      redirect_to judge_activity_path(@activity)
    end

    private

    def update_activity_score
      @activity.score = 40 if @activity.activity_type == 'Curso'
      @activity.score = 25 if @activity.activity_type == 'Plática'
      @activity.score = 10 if @activity.activity_type == 'Post'
      @activity.score += 5 if @activity.english_approve
      events_extra_points = @activity.activity_type == 'Post' ? 5 : 15
      @activity.score += events_extra_points * @activity.locations.where('approve = true').count
      @activity.update_attributes(score: @activity.score)
    end
  end
end

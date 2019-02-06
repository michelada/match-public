module Judge
  class LocationsController < ApplicationController
    def update
      @activity = Activity.find(params[:activity_id])
      @location = @activity.locations.where('id = ?', params[:id]).first
      @location.update_attributes(approve: !@location.approve)
      update_score
      message = @location.approve ? t('labels.approved') : t('labels.unapproved')
      flash[:notice] = message
      redirect_to judge_activity_path(@activity)
    end

    private

    def update_score
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

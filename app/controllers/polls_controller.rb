class PollsController < ApplicationController
  before_action :user_can_access

  def index
    @poll = Poll.last
    redirect_to poll_path(@poll.id)
  end

  def show
    @poll = Poll.find(params[:id])
    @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
    @activity_types = @activities.group(:activity_type).select(:activity_type)
    @best_activities = []
    @best_activities << Activity.best_activities(@poll.id, 0)
    @best_activities << Activity.best_activities(@poll.id, 1)
    @best_activities << Activity.best_activities(@poll.id, 2)

    return unless @activities.empty?

    flash[:alert] = t('poll.empty_activities')
    redirect_to main_index_path
  end

  private

  def user_can_access
    return if current_user.role == 'user'

    flash[:alert] = t('poll.error_accesing')
    redirect_to root_path
  end
end

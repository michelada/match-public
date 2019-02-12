class PollsController < ApplicationController
  before_action :user_can_access
  def index
    @poll = Poll.all.first
    @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
    @activity_types = @activities.group(:activity_type).select(:activity_type)
  end

  private

  def user_can_access
    return if current_user.role == 'user'

    flash[:alert] = t('poll.error_accesing')
    redirect_to root_path
  end
end

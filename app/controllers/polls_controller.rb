class PollsController < ApplicationController
  def index
    @poll = Poll.all.first
    @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
    @activity_types = @activities.group(:activity_type).select(:activity_type)
  end
end

class PollsController < ApplicationController
  def index
    @poll = Poll.all.first
    @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
  end
end

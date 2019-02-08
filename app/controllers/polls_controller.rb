class PollsController < ApplicationController
  def index
    @poll = Poll.all.first
    @activities = Activity.validated_activities
  end
end

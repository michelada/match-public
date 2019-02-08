class PollsController < ApplicationController
  def index
    @poll = Poll.all.first
    @activities = Activity.all
  end
end

module Judge
  class PollsController < ApplicationController
    def index
      @poll = Poll.all.first
      @activities = Activity.from_a_poll(@poll.activities_from, @poll.activities_to)
      @judge_votes = Vote.judge_activities_votes
      @judge_votes = @judge_votes
      @activity_types = @activities.group(:activity_type).select(:activity_type)
      @best_activities = []
      @best_activities << Activity.best_activities(@poll.id, 0)
      @best_activities << Activity.best_activities(@poll.id, 1)
      @best_activities << Activity.best_activities(@poll.id, 2)
      return unless @activities.empty?

      flash[:alert] = t('poll.empty_activities')
      redirect_to main_index_path
    end
  end
end

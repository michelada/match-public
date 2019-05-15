class PollsController < MatchesController
  before_action :user_can_access?

  def show
    @poll.match.content_match? ? initialize_activities : initialize_projects
  end

  private

  def initialize_activities
    @activities_votes = if current_user.judge?
                          @poll.judge_votes
                        else
                          @poll.user_votes(current_user)
                        end
    @activity_types = @poll.activities.group(:activity_type).select(:activity_type)
    @best_activities = []
    3.times { |i| @best_activities << Activity.best_activities(@poll.id, i) }
  end

  def initialize_projects
    @contents = @poll.projects
  end

  def user_can_access?
    @poll = Poll.find(params[:id])
    return if @poll.can_vote? && (@poll.activities.any? || @poll.projects.any?)

    validate_poll_content
    flash[:alert] = t('poll.error_accesing') unless @poll.can_vote?
    redirect_to match_main_index_path(@match)
  end

  def validate_poll_content
    flash[:alert] = t('poll.empty_activities') if @poll.match.content_match? && @poll.activities.empty?
    flash[:alert] = t('poll.empty_projects') if @poll.match.project_match? && @poll.projects.empty?
  end
end

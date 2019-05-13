module PollHelper
  def user_has_voted_for(content)
    @vote ||= Vote.where(user: current_user, poll: @poll)
    @vote.find_by(activity: content)
  end
end

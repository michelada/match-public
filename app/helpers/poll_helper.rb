module PollHelper
  def user_has_voted_for(content)
    @vote ||= @poll.votes.where(user: current_user)
    @vote.find_by(content_id: content.id).present?
  end

  def judges_has_voted_for(content)
    @vote ||= @poll.votes
    @vote.find_by(content_id: content.id).present?
  end
end

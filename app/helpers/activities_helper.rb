module ActivitiesHelper
  def judges_appproves(activity)
    activity.approvations.collect { |status| status.user.email.remove('@michelada.io') }.join(', ')
  end

  def sorted_comments(commentable)
    commentable.feedbacks.sort_by(&:created_at)
  end

  def user_name(user)
    user.name? ? user.name : user.email.remove('@michelada.io').capitalize
  end
end

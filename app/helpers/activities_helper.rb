module ActivitiesHelper
  def user_can_comment?(activity)
    return true if current_user.judge?

    activity.user.team_id == current_user.team_id
  end
end

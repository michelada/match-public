module ActivitiesHelper
  def judges_appproves(activity)
    activity.activity_statuses.collect { |status| status.user.email.remove('@michelada.io') }.join(', ')
  end
end

class ActivityStatus < ApplicationRecord
  scope :user_approve_status_activity, ->(user, activity) { where(activity_id: activity).where(user_id: user).first }
  scope :approves_in_activity, ->(activity) { where(activity_id: activity).where(approve: true) }
end

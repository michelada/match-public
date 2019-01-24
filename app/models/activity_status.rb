class ActivityStatus < ApplicationRecord
  has_many :users
  has_many :activities
  scope :user_aprove_status_activity, ->(user, activity) { where(activity_id: activity).where(user_id: user).first }
  scope :aproves_in_activity, ->(activity) { where(activity_id: activity).where(aprove: true) }
end

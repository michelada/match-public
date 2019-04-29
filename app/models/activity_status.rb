# == Schema Information
#
# Table name: activity_statuses
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer          not null
#  user_id     :integer          not null
#  approve     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ActivityStatus < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  after_create :verify_general_status
  after_destroy :verify_general_status
  scope :user_approve_status_activity, ->(user, activity) { where(activity_id: activity).where(user_id: user).first }
  scope :approves_in_activity, ->(activity) { where(activity_id: activity).where(approve: true) }

  def verify_general_status
    if activity.activity_statuses.count == 3
      activity.update_attributes(status: 2)
    else
      activity.update_attributes(status: 1)
    end
  end
end

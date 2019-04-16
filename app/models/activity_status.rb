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
  scope :user_approve_status_activity, ->(user, activity) { where(activity_id: activity).where(user_id: user).first }
  scope :approves_in_activity, ->(activity) { where(activity_id: activity).where(approve: true) }
end

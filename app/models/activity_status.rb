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
  self.table_name = 'content_approvations'
  belongs_to :content, polymorphic: true
  belongs_to :user
  after_create :verify_general_status
  after_destroy :verify_general_status
  scope :user_approve_status_activity, ->(user, item) { where(content_id: item, user_id: user).first }
  scope :approves_in_activity, ->(item) { where(content_id: item, approve: true, content_type: item.class) }

  def verify_general_status
    if content.class == Activity
      if content.approvations.count == 3
        content.update_attributes(status: 2)
      else
        content.update_attributes(status: 1)
      end
    elsif content.approvations.count == 5
      content.update_attributes(status: 2)
    else
      content.update_attributes(status: 1)
    end
  end
end

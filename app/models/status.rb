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

class Status < ApplicationRecord
  self.table_name = 'item_approves'
  belongs_to :item, polymorphic: true
  belongs_to :user
  after_create :verify_general_status
  after_destroy :verify_general_status
  scope :user_approve_status_activity, ->(user, item) { where(item_id: item, user_id: user).first }
  scope :approves_in_activity, ->(item) { where(item_id: item, approve: true, item_type: item.class) }

  def verify_general_status
    if item.statuses.count == 3
      item.update_attributes(status: 2)
    else
      item.update_attributes(status: 1)
    end
  end
end

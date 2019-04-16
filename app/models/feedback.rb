# == Schema Information
#
# Table name: feedbacks
#
#  id          :bigint(8)        not null, primary key
#  comment     :string
#  activity_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Feedback < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  validates :comment, :activity_id, :user_id, presence: true
end

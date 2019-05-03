# == Schema Information
#
# Table name: feedbacks
#
#  id               :bigint(8)        not null, primary key
#  comment          :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_type :string
#  commentable_id   :bigint(8)
#

class Feedback < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :comment, :user_id, :commentable, presence: true
end

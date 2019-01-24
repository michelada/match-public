class Feedback < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  validates :comment, :activity_id, :user_id, presence: true
end

class Feedback < ApplicationRecord
  belongs_to :activity
  validates :comment, :activity_id, :user_id, presence: true
end

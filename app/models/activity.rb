class Activity < ApplicationRecord
  belongs_to :user
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
end

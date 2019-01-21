class Activity < ApplicationRecord
  has_one :users
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
end

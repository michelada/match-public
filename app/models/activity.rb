class Activity < ApplicationRecord
  belongs_to :user
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
  enum type: { post: 0, platica: 1, curso: 3 }
end

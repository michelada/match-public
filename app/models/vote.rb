class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :poll
  scope :has_voted_for_type, (lambda { |user_id, type|
    where(user_id: user_id)
      .joins(:activity)
      .where('activities.activity_type = ?', type)
  })
end

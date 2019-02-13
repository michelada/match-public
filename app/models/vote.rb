class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :poll
  scope :has_voted_for_type, (lambda { |user_id, type|
    where(user_id: user_id)
      .joins(:activity)
      .where('activities.activity_type = ?', type)
  })

  scope :judge_has_voted_for_type, (lambda { |type|
    joins(:activity)
    .joins(:user)
    .where('activities.activity_type = ?', type)
    .where('users.role = ?', 1)
  })

  scope :judge_activities_votes, -> { joins(:user).where('users.role = ?', 1).select('votes.id as id, votes.activity_id as activity_id') }
end

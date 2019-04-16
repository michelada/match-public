# == Schema Information
#
# Table name: votes
#
#  id          :bigint(8)        not null, primary key
#  activity_id :bigint(8)        not null
#  user_id     :bigint(8)        not null
#  poll_id     :bigint(8)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :integer          not null
#

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

  scope :top_activities, (lambda { |poll|
    where(poll_id: poll)
    .joins(:activity)
      .group('activities.activity_type, activities.name')
    .select('activities.activity_type as type')
      .select('activities.activity_type as type, activities.name as name, sum(votes.value) as points')
      .order('points desc')
    distinct('activities.activity_type')
  })

  scope :judge_activities_votes, (lambda { |poll_id|
    where('votes.poll_id = ?', poll_id)
    .joins(:user).where('users.role = ?', 1)
    .select('votes.id as id, votes.activity_id as activity_id')
  })

  scope :user_activities_votes, (lambda { |poll_id, user_id|
    where('votes.poll_id = ?', poll_id)
    .joins(:user)
    .where('users.id = ?', user_id)
    .select('votes.id as id, votes.activity_id as activity_id')
  })
end

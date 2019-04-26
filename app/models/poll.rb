# == Schema Information
#
# Table name: polls
#
#  id              :bigint(8)        not null, primary key
#  start_date      :date             not null
#  end_date        :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activities_from :date             not null
#  activities_to   :date             not null
#  match_id        :bigint(8)
#

class Poll < ApplicationRecord
  belongs_to :match
  has_many :votes, dependent: :destroy
  has_many :activities, through: :match
  has_many :users, through: :activities
  has_many :teams, through: :users

  scope :pending_polls, (lambda { |date|
    where('(polls.start_date > ?) OR polls.end_date > ? ', date, date)
  })

  scope :last_ended_poll, (lambda { |date|
    where('polls.end_date < ?', date)
    .order('end_date desc')
  })

  scope :users_can_vote, (lambda { |date|
    where('polls.end_date >= ? and polls.start_date <= ?', date, date)
  })

  validates :start_date, :end_date, :activities_from, :activities_to, presence: true
  validate :valid_date_range

  def voted_for_type?(activity, user)
    votes.where(user: user)
         .joins(:activity)
         .where(activities: { activity_type: activity.activity_type })
         .any?
  end

  def can_vote?
    actual_date = Time.now.in_time_zone('Mexico City').to_date
    end_date >= actual_date && start_date <= actual_date
  end

  def activities_by_type
    activities.includes(:votes)
              .where(status: 2)
              .order(:name)
              .group_by(&:activity_type)
  end
end

def valid_date_range
  errors.add(:start_date, I18n.t('polls.error_date_start')) if start_date < Date.today
  errors.add(:start_date, I18n.t('polls.error_dates')) if end_date <= start_date
end

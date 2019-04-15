class Poll < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :activities, through: :votes
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
end

def valid_date_range
  errors.add(:start_date, I18n.t('polls.error_date_start')) if start_date < Date.today
  errors.add(:start_date, I18n.t('polls.error_dates')) if end_date <= start_date
end

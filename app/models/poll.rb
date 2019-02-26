class Poll < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :activities, through: :votes
  scope :enabled_polls, (lambda {
    where('start_date <= ? and end_date >= ?', Date.today, Date.today)
  })
  scope :polls_in_range, (lambda { |in_start_date, in_end_date|
    where('(polls.start_date between ? and ?)  or (polls.end_date between ? and ?)',
          in_start_date, in_end_date, in_start_date, in_end_date)
  })
  validates :start_date, :end_date, :activities_from, :activities_to, presence: true
  validate :valid_date_range
end

def valid_date_range
  errors.add(:start_date, I18n.t('polls.error_date_start')) if start_date < Date.today
  errors.add(:start_date, I18n.t('polls.error_dates')) if end_date <= start_date
end

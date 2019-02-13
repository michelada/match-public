class Poll < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :activities, through: :votes
  scope :enabled_polls, (lambda {
    where('start_date <= ? and end_date >= ?', Date.today, Date.today)
  })
  validates :start_date, :end_date, :activities_from, :activities_to, presence: true
end

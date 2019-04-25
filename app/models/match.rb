# == Schema Information
#
# Table name: matches
#
#  id         :bigint(8)        not null, primary key
#  match_type :integer
#  version    :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ApplicationRecord
  enum match_type: %i[Content Project]

  has_many :activities, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :teams, dependent: :destroy

  validates :match_type, :start_date, :end_date, presence: true
  validate :dates_match?, :no_overlaps?
  before_save :assign_version

  has_one :poll

  def dates_match?
    errors.add(:end_date, I18n.t('errors.end_date_invalid')) if start_date > end_date
  end

  def no_overlaps?
    dates = Match.all.select(:id, :start_date, :end_date)
    dates.each do |date|
      next unless (start_date..end_date).overlaps?(date.start_date..date.end_date) && date.id != id

      errors.add(:start_date, format(I18n.t('errors.overlapped_dates'), match_id: date.id,
                                                                        start_date: date.start_date,
                                                                        end_date: date.end_date))
    end
  end

  def leader_team
    teams.max_by(&:score)
  end

  def top_teams(teams_number)
    teams.sort_by(&:score).reverse&.first(teams_number)
  end

  def assign_version
    latest_version = Match.where(match_type: match_type).max_by(&:version)&.version || 0
    self.version = latest_version + 1
  end

  def teams_by_score
    teams.sort_by(&:score).reverse!
  end

  def winner_team
    teams.max_by(&:score)
  end

  def last_three_activities
    activities.order(created_at: :desc).limit(3)
  end

  def total_score
    activities.where(status: 2).sum(:score)
  end
end

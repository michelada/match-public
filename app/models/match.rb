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
  before_create :assign_version
  after_create :create_poll

  enum match_type: %i[Content Project]

  has_many :activities, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_one :poll, dependent: :delete

  validates :match_type, :start_date, :end_date, presence: true
  validate :dates_match?, :no_overlaps?

  scope :active_match, -> { where('? BETWEEN start_date AND end_date', Date.today) }

  def active?
    actual_date = Date.today.in_time_zone('Mexico City')
    (start_date..end_date).cover?(actual_date)
  end

  def assign_version
    latest_version = Match.where(match_type: match_type).max_by(&:version)&.version || 0
    self.version = latest_version + 1
  end

  def dates_match?
    errors.add(:end_date, I18n.t('errors.end_date_invalid')) if start_date > end_date
  end

  def content_match?
    Content?
  end

  def create_poll
    Poll.create(start_date: end_date + 1,
                end_date: end_date + 7.days,
                match: self)
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

  def last_three_activities
    activities.order(created_at: :desc).limit(3)
  end

  def leader_team
    teams.max_by(&:score)
  end

  def top_teams(teams_number)
    teams.sort_by(&:score).reverse&.first(teams_number)
  end

  def pending_user_approves(user)
    if content_match?
      activities.where.not(name: activities.joins(:approvations)
                                           .where(content_approvations: { user_id: user.id }).pluck(:name))
    else
      projects.where.not(name: projects.joins(:approvations)
                                       .where(content_approvations: { user_id: user.id }).pluck(:name))
    end
  end

  def project_match?
    Project?
  end

  def teams_by_score
    teams.sort_by(&:score).reverse!
  end

  def total_score
    activities.where(status: 2).sum(:score)
  end

  def winner_team
    teams.max_by(&:score)
  end
end

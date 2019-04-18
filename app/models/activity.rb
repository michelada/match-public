# == Schema Information
#
# Table name: activities
#
#  id               :bigint(8)        not null, primary key
#  name             :string           not null
#  english          :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)        not null
#  activity_type    :integer          not null
#  status           :integer          default("Por validar"), not null
#  notes            :string
#  score            :integer          default(0)
#  description      :text
#  pitch_audience   :text
#  abstract_outline :text
#  files            :string
#  english_approve  :boolean
#  slug             :string
#  match_id         :bigint(8)
#

class Activity < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :match
  belongs_to :user
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :created_whithout_name
  has_many :feedback, dependent: :destroy
  has_many :activity_statuses, dependent: :destroy
  has_many :votes, dependent: :destroy
  enum activity_type: %i[Curso Plática Post]
  enum status: { "Por validar": 0, "En revisión": 1, "Aprobado": 2 }
  has_one_attached :file, dependent: :destroy
  before_update :mark_locations_for_removal, :match_valid?

  scope :from_a_poll, (lambda { |start_date, end_date|
    where('created_at >= ? AND created_at <= ? AND status = ?', start_date, end_date, 2)
  })
  scope :checked_activities, ->(actual_user) { joins(:activity_statuses).where('activity_statuses.user_id = ?', actual_user).select('activities.id') }
  scope :unapproved, ->(actual_user) { where('activities.id IN (?)', checked_activities(actual_user)).order('name ASC') }
  scope :pending_activities, ->(actual_user) { where('activities.id NOT IN (?)', checked_activities(actual_user)).order('name ASC') }
  scope :team_activities, ->(team_id) { joins(:user).where('users.team_id = ?', team_id).order('name ASC') }
  scope :order_by_name, -> { order('name ASC') }
  scope :latest_activities, ->(limit_number) { order('created_at DESC').limit(limit_number) }
  scope :total_score, -> { where(status: 2).sum('score') }
  scope :top_teams_by_score, (lambda { |team_count|
    where('activities.status = ?', 2)
      .joins(:user).joins('INNER JOIN teams ON users.team_id = teams.id')
      .group('teams.name')
      .select('teams.name as name, sum(activities.score) as total_score')
      .order('total_score DESC')
      .limit(team_count)
  })

  scope :last_team_winner, (lambda {
    where('activities.status = ?', 2)
      .joins(:user)
      .joins('INNER JOIN teams ON users.team_id = teams.id')
      .group('teams.name')
      .select('teams.name as name, sum(activities.score) as total_score')
      .order('total_score DESC')
      .limit(1)
  })

  scope :team_activities_score, ->(team_id) { team_activities(team_id).where(status: 2).sum('score') }
  scope :best_activities, (lambda { |poll_id, type|
    joins(:votes)
    .where('votes.poll_id = ?', poll_id)
    .where('activities.activity_type = ?', type)
    .group('activities.name')
    .select('activities.name, sum(votes.value) as points')
    .order('points desc').limit(1)
  })
  validates :pitch_audience, :abstract_outline, :description, presence: true, unless: :post?
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :belongs_to_content_match?

  def belongs_to_content_match?
    errors.add(:match_id, I18n.t('errors.no_content_match')) if match&.match_type != 'Content'
  end

  def css_class
    status_class = { "Por validar": 'on-hold', "En revisión": 'review', "Aprobado": 'approved' }
    status_class[status.to_sym]
  end

  def approved?
    status == 'Aprobado'
  end

  def to_param
    slug
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def workshop?
    Curso?
  end

  def talk?
    Plática?
  end

  def post?
    Post?
  end

  def can_edit?(user_id)
    user.id == user_id
  end

  def created_whithout_name(location)
    location[:name].blank? && new_record?
  end

  def mark_locations_for_removal
    locations.each do |location|
      location.mark_for_destruction if location.name.blank?
    end
  end

  def match_valid?
    raise 'Activity can only exist in project matches' if match.match_type != 'Content'
  end
end

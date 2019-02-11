# == Schema Information
#
# Table name: activities
#
#  id            :bigint(8)        not null, primary key
#  name          :string           not null
#  english       :boolean          not null
#  location      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint(8)
#  activity_type :integer          not null
#  status        :integer          default("Por validar"), not null
#

class Activity < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :feedback
  has_many :activity_statuses
  enum activity_type: { Curso: 0, Plática: 1, Post: 2 }
  enum status: { "Por validar": 0, "En revisión": 1, "Aprobado": 2 }
  mount_uploader :activity_file, ActivityFileUploader
  scope :user_activities, ->(actual_user) { where(user_id: actual_user).order('name ASC') }
  scope :checked_activities, ->(actual_user) { joins(:activity_statuses).where('activity_statuses.user_id = ?', actual_user).select('activities.id') }
  scope :unnaprove, ->(actual_user) { where('activities.id NOT IN (?)', checked_activities(actual_user)).order('name ASC')}
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
  scope :team_activities_score, ->(team_id) { team_activities(team_id).where(status: 2).sum('score') }

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def css_class
    status_class = { "Por validar": 'on-hold', "En revisión": 'review', "Aprobado": 'approved' }
    status_class[status.to_sym]
  end
end

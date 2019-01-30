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
  has_and_belongs_to_many :locations, dependent: :destroy
  has_many :feedback
  has_many :activity_statuses
  enum activity_type: { Curso: 0, Platica: 1, Post: 2 }
  enum status: { "Por validar": 0, "En revisión": 1, "Aprobado": 2 }
  scope :user_activities, ->(actual_user) { where(user_id: actual_user) }
  scope :checked_activities, ->(actual_user) { joins(:activity_statuses).where('activity_statuses.user_id = ?', actual_user).select('activities.id') }
  scope :pending_activities, ->(actual_user) { where('activities.id NOT IN (?)', checked_activities(actual_user)) }
  scope :team_activities, ->(team_id) { joins(:user).where('users.team_id = ?', team_id) }
  scope :team_score, (lambda {
    where('activities.status = ?', 2)
      .joins(:user).joins('INNER JOIN teams ON users.team_id = teams.id')
      .group('teams.name')
      .select('teams.name as name, sum(activities.score) as total_score')
      .order('total_score DESC LIMIT 5')
  })
  scope :team_activities_score, ->(team_id) { team_activities(team_id).where(status: 2).sum('score') }

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end

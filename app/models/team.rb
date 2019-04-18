# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  match_id   :bigint(8)
#

# Teams of mcm
class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :match
  has_one :project, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :activities, through: :users
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  scope :teams_count, -> { count }

  def score
    case match.match_type
    when 'Content'
      Activity.team_activities_score(id)
    when 'Project'
      project.score
    else
      raise 'Invalid match type'
    end
  end
end

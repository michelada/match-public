# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Teams of mcm
class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :users, dependent: :nullify
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  scope :teams_count, -> { count }

  def activities
    Activity.team_activities(id)
  end

  def score
    Activity.team_activities_score(id)
  end
end

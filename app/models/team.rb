# Teams of mcm
class Team < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  scope :obtain_top_three_teams, -> { order('score DESC limit 5') }
end
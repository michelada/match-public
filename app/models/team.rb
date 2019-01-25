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
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  scope :obtain_top_five_teams, -> { order('score DESC limit 5') }
end

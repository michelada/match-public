# Teams of mcm
class Team < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end

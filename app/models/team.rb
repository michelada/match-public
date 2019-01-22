# Teams of mcm
class Team < ApplicationRecord
  has_many :users
  validates :user_id, :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end

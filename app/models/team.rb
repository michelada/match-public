# Teams of mcm
class Team < ApplicationRecord
  has_many :users
  validates :user_id, :name, :english, precense: true
  validates :name, uniqueness: { case_sensitive: false }
end

class Poll < ApplicationRecord
  has_many :votes
  has_many :activities, throgh: :vote
end

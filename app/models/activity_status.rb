class ActivityStatus < ApplicationRecord
  has_many :users
  has_many :activities
end

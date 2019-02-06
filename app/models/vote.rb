class Vote < ApplicationRecord
  has_one :user
  has_one :activity
  has_one :poll
end

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :poll
end

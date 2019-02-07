class Vote < ApplicationRecord
  belong_to :user
  belongs_to :activity
  belong_to :poll
end

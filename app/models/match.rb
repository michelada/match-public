# == Schema Information
#
# Table name: matches
#
#  id         :bigint(8)        not null, primary key
#  match_type :integer
#  version    :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ApplicationRecord
  enum match_type: %i[Content Project]

  has_many :activities
  has_many :projects
  has_one :poll
  has_many :teams

  validates :match_type, :start_date, :end_date, presence: true
end

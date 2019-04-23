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

  def teams_by_score
    teams.sort_by(&:score).reverse!
  end

  def winner_team
    teams.max_by(&:score)
  end

  def last_three_activities
    activities.order(created_at: :desc).limit(3)
  end

  def total_score
    activities.where(status: 2).sum(:score)
  end
end

# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  description  :text
#  repositories :text
#  features     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  match_id     :bigint(8)
#  team_id      :bigint(8)
#

class Project < ApplicationRecord
  belongs_to :match
  belongs_to :team
end

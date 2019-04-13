# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  match_id   :bigint(8)
#

class TeamSerializer < ActiveModel::Serializer
  attributes :name, :score
end

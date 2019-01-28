# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeamSerializer < ActiveModel::Serializer
  attributes :name, :score
end

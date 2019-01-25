# == Schema Information
#
# Table name: activities
#
#  id            :bigint(8)        not null, primary key
#  name          :string           not null
#  english       :boolean          not null
#  location      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint(8)
#  activity_type :integer          not null
#  status        :integer          default("Por validar"), not null
#

class ActivitySerializer < ActiveModel::Serializer
  attributes :name, :location, :activity_type
end

# == Schema Information
#
# Table name: activities
#
#  id               :bigint(8)        not null, primary key
#  name             :string           not null
#  english          :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)        not null
#  activity_type    :integer          not null
#  status           :integer          default("Por validar"), not null
#  notes            :text
#  score            :integer          default(0)
#  description      :text
#  pitch_audience   :text
#  abstract_outline :text
#  files            :string
#  english_approve  :boolean
#  slug             :string
#  match_id         :bigint(8)
#

class ActivitySerializer < ActiveModel::Serializer
  attributes :name, :location, :activity_type
end

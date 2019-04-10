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
#  notes            :string
#  score            :integer          default(0)
#  description      :text
#  pitch_audience   :text
#  abstract_outline :text
#  activity_file    :string
#  english_approve  :boolean
#  slug             :string
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

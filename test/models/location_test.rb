# == Schema Information
#
# Table name: locations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  approve     :boolean          default(FALSE)
#  activity_id :bigint(8)        not null
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'location must be invalid with no activity' do
    location = Location.new
    refute location.valid?
  end

  test 'location must be valid with activity' do
    activity = activities(:activity_workshop)
    location = Location.new(activity: activity)
    assert location.valid?
  end
end

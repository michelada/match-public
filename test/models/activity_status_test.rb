# == Schema Information
#
# Table name: activity_statuses
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer          not null
#  user_id     :integer          not null
#  approve     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ActivityStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

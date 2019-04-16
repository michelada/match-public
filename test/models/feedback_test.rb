# == Schema Information
#
# Table name: feedbacks
#
#  id          :bigint(8)        not null, primary key
#  comment     :string
#  activity_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'feedback must be invalid with no comment' do
    user = users(:user)
    activity = activities(:activity_workshop)
    feedback = Feedback.new(activity: activity,
                            user: user)
    refute feedback.valid?
  end

  test 'feedback must ve invalid with no activity' do
    user = users(:user)
    feedback = Feedback.new(comment: 'ANninteligent person who I loves to work with',
                            user: user)
    refute feedback.valid?
  end

  test 'feedback must ve invalid with no user' do
    activity = activities(:activity_workshop)
    feedback = Feedback.new(comment: 'An inteligent person who I loves to work with',
                            activity: activity)
    refute feedback.valid?
  end

  test 'feedback must be valid with all data' do
    user = users(:user)
    activity = activities(:activity_workshop)
    feedback = Feedback.new(comment: 'An inteligent person who I loves to work with',
                            activity: activity,
                            user: user)
    assert feedback.valid?
  end
end

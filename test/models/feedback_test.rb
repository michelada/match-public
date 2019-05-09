# == Schema Information
#
# Table name: feedbacks
#
#  id               :bigint(8)        not null, primary key
#  comment          :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  file             :string
#  commentable_type :string
#  commentable_id   :bigint(8)
#

require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  setup do
    @user = users(:user)
    @activity = activities(:activity_workshop)
  end

  test 'feedback can belong to an activity' do
    feedback = @activity.feedbacks.new(comment: 'An inteligent person who I loves to work with',
                                       commentable: @activity,
                                       user: @user)

    assert_equal @activity, feedback.commentable
    assert_equal feedback, @activity.feedbacks.first
  end

  test 'feedbacks can belong to a project' do
    project = projects(:simple_project)
    feedback = project.feedbacks.new(comment: 'An inteligent person who I loves to work with',
                                     commentable: project,
                                     user: @user)

    assert_equal project, feedback.commentable
    assert_equal feedback, project.feedbacks.first
  end

  test 'feedback must be invalid with no comment' do
    feedback = Feedback.new(commentable: @activity,
                            user: @user)
    refute feedback.valid?
  end

  test 'feedback must ve invalid with no commentable' do
    feedback = Feedback.new(comment: 'ANninteligent person who I loves to work with',
                            user: @user)
    refute feedback.valid?
  end

  test 'feedback must ve invalid with no user' do
    feedback = Feedback.new(comment: 'An inteligent person who I loves to work with',
                            commentable: @activity)
    refute feedback.valid?
  end

  test 'feedback must be valid with all attributes' do
    feedback = Feedback.new(comment: 'An inteligent person who I loves to work with',
                            commentable: @activity,
                            user: @user)
    assert feedback.valid?
  end
end

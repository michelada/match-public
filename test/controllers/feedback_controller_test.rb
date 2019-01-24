require 'test_helper'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'user can create a comment' do
    sign_in @user
    feedback = feedbacks(:feedback)
    activity_android = activities(:android_studio)
    post activity_feedbacks_path(activity_android.id), params: { feedback: { name: 'Example',
                                                                             user_id: feedback.user_id,
                                                                             activity_id: feedback.activity_id } }
    assert_redirected_to activity_path(feedback.activity_id)
  end
end

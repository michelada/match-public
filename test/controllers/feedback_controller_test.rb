require 'test_helper'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @match = Match.last
  end

  test 'user can create a comment' do
    sign_in @user
    feedback = feedbacks(:feedback)
    activity_android = activities(:android_studio)
    post match_activity_feedbacks_path(@match, activity_android.id), params: { feedback: { comment: feedback.comment,
                                                                                           user_id: feedback.user_id,
                                                                                           activity_id: feedback.activity_id } }
    assert_redirected_to match_activity_path(@match, activity_android.slug)
    assert_equal flash[:notice], I18n.t('comments.created')
  end

  test 'user can not give feedback witout a comment' do
    sign_in @user
    feedback = feedbacks(:feedback)
    activity_android = activities(:android_studio)
    post match_activity_feedbacks_path(@match, activity_android.id), params: { feedback: { user_id: feedback.user_id,
                                                                                           activity_id: feedback.activity_id } }
    assert_redirected_to match_activity_path(@match, activity_android.slug)
    assert_equal flash[:alert], I18n.t('comments.error_creating')
  end
end

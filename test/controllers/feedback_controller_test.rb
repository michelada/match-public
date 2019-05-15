require 'test_helper'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @match = Match.last
    feedback = feedbacks(:poo_java_feedback)
    @params = { feedback: { comment: feedback.comment,
                            user_id: feedback.user_id,
                            commentable: feedback.commentable } }
  end

  test 'user can create a comment' do
    sign_in @user
    activity_android = activities(:android_studio)
    post match_activity_feedbacks_path(@match, activity_android.id), params: @params
    assert_redirected_to match_activity_path(@match, activity_android.slug)
    assert_equal flash[:notice], I18n.t('comments.created')
  end

  test 'user can not give feedback witout a comment' do
    sign_in @user
    @params[:feedback].delete(:comment)
    activity_android = activities(:android_studio)
    post match_activity_feedbacks_path(@match, activity_android.id), params: @params
    assert_redirected_to match_activity_path(@match, activity_android.slug)
    assert_equal flash[:alert], I18n.t('comments.error_creating')
  end
end

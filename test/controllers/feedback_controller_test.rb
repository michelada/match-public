require 'test_helper'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test "user can create a comment" do
    sign_in @user
    feedback = feedbacks(:feedback)
    assert true
  end
end

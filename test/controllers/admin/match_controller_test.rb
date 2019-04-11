require 'test_helper'

class MatchControllerTest < ActionDispatch::IntegrationTest
  def setup
    @match = matches(:content_match)
    @user = users(:admin_user)
  end

  test 'no logged user can not visit admin match page' do
    get admin_matches_path
    assert_redirected_to new_user_session_path
  end

  test 'admin can view a match information' do
    sign_in @user
    get admin_match_path(@match)
    assert_response :success
  end
end

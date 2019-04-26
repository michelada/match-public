require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @match = matches(:active_content_match)
  end

  test 'no logged user can not visit main index' do
    get match_main_index_path(@match)
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user can visit main index' do
    user_with_team = users(:user_with_team)
    sign_in user_with_team

    get match_main_index_path(@match)
    assert_response :success
  end
end

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'no logged user can no visit root path' do
    get root_path
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user canm visit root path' do
    sign_in @user
    get root_path
    assert_response :success
  end
end

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'no logged user can not visit main index' do
    get main_index_path
    assert_redirected_to root_path, 'Controller response unexpected'
  end

  test 'logged user can visit main index' do
    user_with_team = users(:user_with_team)
    sign_in user_with_team
    get main_index_path
    assert_response :success
  end
end

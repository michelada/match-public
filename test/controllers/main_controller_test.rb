require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'no logged user can no visit main index' do
    get main_index_path
    assert_redirected_to root_path, 'Controller response unexpected'
  end

  test 'logged user can visit main index' do
    sign_in @user
    get main_index_path
    assert_response :success
  end
end

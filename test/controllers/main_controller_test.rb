require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'no logged user can not visit main page' do
    get root_path
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user can visit main page' do
    @user_with_team = users(:user_with_team)
    sign_in @user_with_team
    get root_path
    assert_response :success
  end

  test 'logged user with no team is redirected to create_team view instead of main page' do
    sign_in @user
    get new_team_path
    assert_response :success
  end

  test 'logged user with no team can not add a new activity' do
    sign_in @user
    get new_activity_path
    assert_redirected_to new_team_path, 'Controller response unexpected'
  end
  test 'logged users can view main page' do
    sign_in @user
    get 
    assert_redirected_to new_team_path, 'Controller response unexpected'
  end
end

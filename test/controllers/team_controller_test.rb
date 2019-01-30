require 'test_helper'
require 'pry'

class TeamControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @team_user = users(:user_with_team)
  end

  test 'no logged in users can not visit the new team view' do
    get new_team_path
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged in users can visit new team' do
    sign_in @user
    get new_team_path
    assert_response :success, 'Controller response unexpected'
  end

  test 'logged user can create a team' do
    sign_in @user
    post teams_path, params: { team: { name: 'michelada' }, user_invitation_1: { email: '' }, user_invitation_2: { email: '' } } 
    assert_redirected_to main_index_path, 'Controller reponse unexpected'
  end

  test 'no loged user can no visit activity team show' do
    get team_path(@team_user.team)
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'loged user can visit team show' do
    sign_in @team_user
    get team_path(@team_user.team)
    assert_response :success
  end
end

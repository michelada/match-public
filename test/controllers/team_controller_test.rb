require 'test_helper'
require 'pry'

class TeamControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @team_user = users(:user_with_team)
    Match.last.destroy
    @team_user.teams << teams(:teamMatch)
    @match = Match.last
  end

  test 'no logged in users can not visit the new team view' do
    get new_match_team_path(@match)
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged in users can visit new team' do
    sign_in @user
    get new_match_team_path(@match)
    assert_response :success, 'Controller response unexpected'
  end

  test 'logged user can create a team' do
    sign_in @user
    post match_teams_path(@match), params: { team: { name: 'michelada' }, user_invitations: { email_1: '', email_2: '' } }
    assert_redirected_to match_main_index_path(@match), 'Controller reponse unexpected'
  end

  test 'no loged user can no visit activity team show' do
    get match_team_path(@match, @team_user.current_team)
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'loged user can visit team show' do
    sign_in @team_user
    get match_team_path(@match, @team_user.current_team)
    assert_response :success
  end
end

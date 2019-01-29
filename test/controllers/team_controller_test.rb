require 'test_helper'
require 'pry'

class TeamControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
  end

  test 'no loged in users can not visit the new team view' do
    get new_team_path
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'loged in users can visit' do
    sign_in @user
    get new_team_path
    assert_response :success, 'Controller response unexpected'
  end

  test 'loged user can create a team' do
    sign_in @user
    post teams_path, params: { team: { name: 'michelada' } }
    assert_redirected_to main_index_path, 'Controller reponse unexpected'
  end
end

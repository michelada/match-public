require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @user_with_team = users(:user_with_team)
  end

  test 'no logged user can not acces to new_activity path' do
    get new_activity_path
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user can access to new_activity path' do
    sign_in @user_with_team
    get new_activity_path
    assert_response :success
  end

  test 'loged user with team can create an activity' do
    team = teams(:team3)
    sign_in @user_with_team
    post activities_path, params: { activity: { name: 'Android Studio', activity_type: 'Curso', english: 0 }, locations_string: 'UDEC,TEC' }
    assert_redirected_to team_path(team), 'Controller response unexpected'
  end

  test 'no loged user can not create an activity' do
    post activities_path, params: { activity: { name: 'Android Studio', activity_type: 'Curso', english: 0 }, locations_string: 'UDEC,TEC' }
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'users with no team can not access create activity view' do
    sign_in @user
    get new_activity_path
    assert_redirected_to new_team_path, 'Controller response unexpected'
  end

  test 'users can not created an activity if the activity name is blank' do
    sign_in @user_with_team
    post activities_path, params: { activity: { name: '', activity_type: 'Curso', english: 0 }, locations_string: '' }
    assert_response :success
    # verify flash[]
  end

  test 'users without teams redirect to create team.' do
    sign_in @user
    get new_activity_path
    assert_redirected_to new_team_path
  end

  test 'no logged user can view main page.' do
    get root_path
    assert_response :success
  end
end

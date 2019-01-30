require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user)
    @team = teams(:team3)
    @user_with_team = users(:user_with_team)
  end

  test 'loged user can create an activity' do
    sign_in @user_with_team
    post activities_path, params: { activity: { name: 'Android Studio', activity_type: 'Curso', english: 0 }, locations_string: 'UDEC,TEC' }
    assert_redirected_to team_path(@team), 'Controller response unexpectefd'
  end

  test 'users with no team can not access create activity view' do
    sign_in @user
    get new_activity_path
    assert_redirected_to new_team_path, 'Controller response unexpected'
  end
end

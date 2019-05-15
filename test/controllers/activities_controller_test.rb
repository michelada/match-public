require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # All controllers set @match = Match.last by default, inside tests, Match.last is a project match
    # and test will fail because activities can only be created inside a content match. This will be fixed
    # in the future, by now this is good to go.
    Match.all.each { |m| m.destroy if m.id != 1 }

    @user = users(:user)
    @user_with_team = users(:user_with_team)
    @match = matches(:content_match)
    @match.update_attributes(start_date: Date.today - 2, end_date: Date.today + 2)

    @activity_params = { activity: { name: 'Android Studio',
                                     description: 'prueba de Android',
                                     pitch_audience: 'prueba de campos requeridos',
                                     abstract_outline: 'prueba abstrac',
                                     activity_type: 'Curso',
                                     english: 0,
                                     match_id: @match.id } }
  end

  test 'no logged user can not access to new_activity path' do
    get new_match_activity_path(@match)
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
    assert_equal flash[:alert], I18n.t('devise.failure.unauthenticated')
  end

  test 'logged user with team can access to new_activity path' do
    sign_in @user_with_team
    get new_match_activity_path(@match)
    assert_response :success
  end

  test 'logged user with team can create an activity' do
    team = teams(:team3)
    sign_in @user_with_team
    post match_activities_path(@match), params: @activity_params
    assert_redirected_to match_team_path(@match, team), 'Controller response unexpected'
    assert_equal flash[:notice], I18n.t('activities.messages.uploaded')
  end

  test 'no loged user can not create an activity' do
    post match_activities_path(@match), params: @activity_params
    assert_redirected_to new_user_session_path, 'Controller response unexpected'
    assert_equal flash[:alert], I18n.t('devise.failure.unauthenticated')
  end

  test 'users with no team can not access to create activity view' do
    sign_in @user
    get new_match_activity_path(@match)
    assert_redirected_to new_match_team_path(@match), 'Controller response unexpected'
  end

  test 'users can not created an activity if the activity name is blank' do
    sign_in @user_with_team
    @activity_params[:activity][:name] = ''
    post match_activities_path(@match), params: @activity_params
    assert_response :success
    assert_equal flash[:alert], I18n.t('activities.messages.error_creating')
  end

  test 'user with no team is redirected to create team path' do
    sign_in @user
    get new_match_activity_path(@match)
    assert_redirected_to new_match_team_path(@match)
    assert_equal I18n.t('projects.no_team'), flash[:alert]
  end

  test 'users cannot create an activity if no match is active' do
    @match.update_attribute(:end_date, Date.today - 1)
    sign_in @user_with_team

    get new_match_activity_path(@match)
    assert_redirected_to match_main_index_path(@match)
    assert_equal I18n.t('activities.closed'), flash[:alert]
  end

  test 'user can no access to new project view' do
    sign_in @user_with_team
    get new_match_project_path(@match)
    assert_redirected_to root_path, 'Controller response unexpected'
    assert_equal I18n.t('match.error_type'), flash[:alert]
  end
end

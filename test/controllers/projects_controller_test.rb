require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @match = matches(:active_project_match)
  end

  test 'no logged user cannot create a new activity' do
    get new_match_project_path(@match)

    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user without project can create a new project' do
    sign_in users(:user_with_team)

    get new_match_project_path(@match)

    assert_response :success, 'Controller response unexpected'
  end

  test 'logged user with a project cannot create a new project' do
    user = users(:user_test1)
    sign_in user

    get new_match_project_path(@match)

    assert_redirected_to match_team_path(@match, user.team)
    assert_equal flash[:alert], I18n.t('projects.already_have_one')
  end

  test 'users with no team cannot create a project' do
    sign_in users(:user)

    get new_match_project_path(@match)

    assert_redirected_to new_match_team_path(@match)
    assert_equal flash[:alert], I18n.t('projects.no_team')
  end
end

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @match = matches(:active_project_match)
    @project_params = { project: { name: 'Example project',
                                   description: 'Random description for the example project',
                                   repositories: 'GitHub-repo, GitLab-repo',
                                   features: 'User session',
                                   match: @match,
                                   team: '' } }
  end

  test 'no logged user cannot access to new activity view' do
    get new_match_project_path(@match)

    assert_redirected_to new_user_session_path, 'Controller response unexpected'
  end

  test 'logged user without project can access to new project view' do
    user = users(:user_with_team)
    user.project.destroy
    sign_in user

    get new_match_project_path(@match)

    assert_response :success, 'Controller response unexpected'
  end

  test 'logged user with a project cannot access to new project view' do
    user = users(:user_test1)
    sign_in user

    get new_match_project_path(@match)

    assert_redirected_to match_team_path(@match, user.current_team)
    assert_equal flash[:alert], I18n.t('projects.already_have_one')
  end

  test 'users with no team cannot access to new project view' do
    user = users(:user)
    sign_in user

    get new_match_project_path(@match)

    assert_redirected_to new_match_team_path(@match)
    assert_equal flash[:alert], I18n.t('projects.no_team')
  end

  test 'logged user with team can create a new project' do
    user = users(:user_with_team)
    user.project.destroy
    sign_in user

    @project_params[:project][:team] = user.current_team
    post match_projects_path(@match), params: @project_params
    assert_redirected_to match_team_path(@match, user.current_team)
    assert_equal I18n.t('projects.created'), flash[:notice]
  end

  test 'logged user with team cannot create a new project without description' do
    user = users(:user_with_team)
    user.project.destroy
    sign_in user

    @project_params[:project][:team] = user.current_team
    @project_params[:project].delete(:description)
    post match_projects_path(@match), params: @project_params
    assert_response :success
    assert_equal flash[:alert], I18n.t('projects.error_creating')
  end

  test 'logged user with team cannot create a new project without name' do
    user = users(:user_with_team)
    user.project.destroy
    sign_in user

    @project_params[:project][:team] = user.current_team
    @project_params[:project].delete(:name)
    post match_projects_path(@match), params: @project_params
    assert_response :success
    assert_equal flash[:alert], I18n.t('projects.error_creating')
  end

  test 'user can update project attributes' do
    user = users(:user_test1)
    sign_in user

    @project_params[:project][:team] = user.current_team
    @project_params[:project][:name] = 'A new project name'
    put match_project_path(@match, user.current_team.project), params: @project_params
    assert_redirected_to match_team_path(@match, user.current_team)
    assert_equal flash[:notice], I18n.t('projects.updated')
  end

  test 'user can not modify another one teams project' do
    project = projects(:simple_project)
    project.update_attributes(match_id: 6)

    user = users(:user_test1)
    sign_in user

    @project_params[:project][:team] = user.current_team
    put match_project_path(@match, project), params: @project_params
    assert_equal flash[:alert], I18n.t('activities.messages.no_permitted')
    assert_redirected_to new_match_team_path(@match)
  end

  test 'user can no access to new activity view' do
    user = users(:user_with_team)
    user.project.destroy
    sign_in user

    get new_match_activity_path(@match)
    assert_redirected_to root_path
    assert_equal flash[:alert], I18n.t('match.error_type')
  end
end

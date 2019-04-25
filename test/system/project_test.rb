require 'application_system_test_case'

class ProjectTest < ApplicationSystemTestCase
  def setup
    @match = matches(:active_project_match)
    @user = users(:user_test1)
    @user_no_project = users(:user_with_team)
  end

  test 'user must fill the required fields to upload an activity' do
    login_as @user_no_project

    visit new_match_project_path(@match)

    fill_in 'project[name]', with: 'Test project'
    fill_in 'project[description]', with: 'Filled from system tests'

    click_button 'Create Project'

    assert page.has_content?(I18n.t('projects.created'))
  end

  test 'users can edit projects' do
    login_as @user
    visit match_team_path(@match, @user.team)

    click_link I18n.t('buttons.edit')

    fill_in 'project[name]', with: 'Test project updated'

    click_button 'Update Project'

    assert page.has_content?('Test project updated')
  end
end

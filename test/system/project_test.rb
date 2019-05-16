require 'application_system_test_case'

class ProjectTest < ApplicationSystemTestCase
  def setup
    @match = matches(:active_project_match)
    @user = users(:user_test1)
    @user_no_project = users(:user_with_team)
  end

  test 'user can upload a project with all the attributes' do
    login_as @user_no_project
    @user_no_project.project.delete
    visit match_team_path(@match, @user_no_project.current_team)

    find("a[href='/match/#{@match.id}/projects/new']").click

    fill_in 'project[name]', with: 'Test project'
    fill_in 'project[description]', with: 'Filled from system tests'
    fill_in 'project[features]', with: 'Is cool'

    click_button 'Create Project'

    assert page.has_content?(I18n.t('projects.created'))
  end

  test 'user cannot create a project if required fields are blank' do
    login_as @user_no_project
    @user_no_project.project.delete
    visit new_match_project_path(@match)

    click_button 'Create Project'

    assert page.has_content?(I18n.t('activerecord.errors.models.project.attributes.name.blank'))
    assert page.has_content?(I18n.t('activerecord.errors.models.project.attributes.description.blank'))
  end

  test 'users can edit projects' do
    login_as @user

    visit match_team_path(@match, @user.current_team)
    within('.activities-table') do
      find("a[href='/match/#{@match.id}/projects/#{@user.current_team.project.slug}/edit']").click
    end
    fill_in 'project[name]', with: 'Test project updated'
    click_button 'Update Project'

    assert page.has_content?('Test project updated')
  end

  test 'users cannot see new project link if they have a project' do
    login_as @user

    visit match_team_path(@match, @user.current_team)

    assert_not page.has_content?("a[href='/match/#{@match.id}/projects/new']")
  end
end

require 'application_system_test_case'

class ContentApprovationsTest < ApplicationSystemTestCase
  def setup
    login_as users(:judge_user)
  end

  test 'judge user can approve an activity' do
    Match.last.destroy
    match = matches(:active_content_match)
    match.poll.update_attributes(start_date: Date.today)
    activity = activities(:ruby_as_day_to_day)

    visit match_judge_main_index_path(match)
    find("a[href='/match/#{match.id}/activities/#{activity.id}']").click
    find("a[href='/match/#{match.id}/judge/activities/#{activity.slug}/content_approvations']").click

    assert page.has_content?(I18n.t('activities.messages.approved'))
  end

  test 'judge can unapprove an activity' do
    Match.last.destroy
    match = matches(:active_content_match)
    match.poll.update_attributes(start_date: Date.today)
    activity = activities(:activity_workshop)
    activity_approvation = activity_statuses(:poo_java_approvation)

    visit match_judge_main_index_path(match)
    find("a[href='#all_activities_container']").click
    find("a[href='/match/#{match.id}/activities/#{activity.id}']").click
    find("a[href='/match/#{match.id}/judge/activities/#{activity.slug}/content_approvations/#{activity_approvation.id}']").click
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('activities.messages.unapproved'))
  end

  test 'judge can approve a project' do
    match = matches(:active_project_match)
    match.poll.update_attributes(start_date: Date.today)
    project = projects(:project_no_validated)

    visit match_judge_main_index_path(match)
    find("a[href='/match/#{match.id}/projects/#{project.id}']").click
    find("a[href='/match/#{match.id}/judge/projects/#{project.slug}/content_approvations']").click

    assert page.has_content?(I18n.t('projects.messages.approved'))
  end

  test 'judge can unnaprove a project' do
    match = matches(:active_project_match)
    match.poll.update_attributes(start_date: Date.today)

    project = projects(:simple_project2)
    project_approvation = activity_statuses(:simple_project2_approvation)

    visit match_judge_main_index_path(match)
    find("a[href='#all_activities_container']").click
    find("a[href='/match/#{match.id}/projects/#{project.id}']").click
    find("a[href='/match/#{match.id}/judge/projects/#{project.slug}/content_approvations/#{project_approvation.id}']").click
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('projects.messages.unapproved'))
  end
end

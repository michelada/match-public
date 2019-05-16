require 'test_helper'

class ContentStatusControllerTest < ActionDispatch::IntegrationTest
  def setup
    @judge_user = users(:judge_user)
    @normal_user = users(:user)
  end

  test 'judge can approve an activity' do
    login_as @judge_user
    activity_match = matches(:active_content_match)
    activity_java = activities(:activity_workshop)

    post match_judge_activity_content_approvations_path(activity_match, activity_java)

    assert_redirected_to match_activity_path(activity_match, activity_java)
    assert_equal I18n.t('activities.messages.approved'), flash[:notice]
  end

  test 'judge can unapprove an activity' do
    login_as @judge_user
    activity_match = matches(:active_content_match)
    simple_activity = activities(:simple_activity2)
    activity_approvation = activity_statuses(:simple_activity2_approvation)

    delete match_judge_activity_content_approvation_path(activity_match, simple_activity, activity_approvation)

    assert_redirected_to match_activity_path(activity_match, simple_activity)
    assert_equal I18n.t('activities.messages.unapproved'), flash[:notice]
  end

  test 'judge can approve a project' do
    login_as @judge_user
    project_match = matches(:active_project_match)
    simple_project = projects(:simple_project2)

    post match_judge_project_content_approvations_path(project_match, simple_project)

    assert_redirected_to match_project_path(project_match, simple_project)
    assert_equal I18n.t('projects.messages.approved'), flash[:notice]
  end

  test 'judge can unapprove a project' do
    login_as @judge_user
    project_match = matches(:active_project_match)
    simple_project2 = projects(:simple_project2)
    project_approvation = activity_statuses(:simple_project2_approvation)

    delete match_judge_project_content_approvation_path(project_match, simple_project2, project_approvation)

    assert_redirected_to match_project_path(project_match, simple_project2)
    assert_equal I18n.t('projects.messages.unapproved'), flash[:notice]
  end

  test 'no judge user can not approve an activity' do
    login_as @normal_user
    activity_match = matches(:active_content_match)
    activity_java = activities(:activity_workshop)

    post match_judge_activity_content_approvations_path(activity_match, activity_java)

    assert_redirected_to root_path
    assert_equal I18n.t('activities.messages.not_permitted'), flash[:alert]
  end

  test 'no judge user can not unapprove an activity' do
    login_as @normal_user
    activity_match = matches(:active_content_match)
    simple_activity = activities(:simple_activity2)
    activity_approvation = activity_statuses(:simple_activity2_approvation)

    delete match_judge_activity_content_approvation_path(activity_match, simple_activity, activity_approvation)

    assert_redirected_to root_path
    assert_equal I18n.t('activities.messages.not_permitted'), flash[:alert]
  end

  test 'no judge user can not approve a project' do
    login_as @normal_user
    project_match = matches(:active_project_match)
    simple_project = projects(:simple_project2)

    post match_judge_project_content_approvations_path(project_match, simple_project)

    assert_redirected_to root_path
    assert_equal I18n.t('activities.messages.not_permitted'), flash[:alert]
  end

  test 'no judge user can not unapprove a project' do
    login_as @normal_user
    project_match = matches(:active_project_match)
    simple_project2 = projects(:simple_project2)
    project_approvation = activity_statuses(:simple_project2_approvation)

    delete match_judge_project_content_approvation_path(project_match, simple_project2, project_approvation)

    assert_redirected_to root_path
    assert_equal I18n.t('activities.messages.not_permitted'), flash[:alert]
  end
end

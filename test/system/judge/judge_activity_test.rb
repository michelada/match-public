require 'application_system_test_case'

class JudgeActivityTest < ApplicationSystemTestCase
  def setup
    @user = users(:judge_user)
    login_as @user
    Match.last.destroy
    @match = matches(:active_content_match)
    @match.poll.update_attributes(start_date: Date.today)
  end

  test 'judge user can approve an activity' do
    activity = activities(:ruby_as_day_to_day)

    visit match_judge_main_index_path(@match)
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.id}']").click
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/activity_status']").click

    assert page.has_content?(I18n.t('activities.messages.approved'))
  end

  test 'judge can unapprove an activity' do
    activity = activities(:activity_workshop)
    visit match_judge_main_index_path(@match)
    find("a[href='#all_activities_container']").click
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.id}']").click
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/activity_status/#{activity.id}']").click
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('activities.messages.unapproved'))
  end

  test 'judge can see only waiting activities on the on wait sectin' do
    visit match_judge_main_index_path(@match)

    assert page.has_content?('POO ruby')
    assert page.has_content?('Rails as a Day to Day')
  end

  test 'judge can see only in revision activities on the revision section' do
    activity = activities(:activity_talk)
    activity.update_attributes(status: 1)

    visit match_judge_main_index_path(@match)
    find("a[href='#pending_activities_container']").click

    assert page.has_content?('POO ruby')
  end

  test 'judge can see all activities in the all activities section' do
    visit match_judge_main_index_path(@match)
    find("a[href='#all_activities_container']").click

    assert page.has_content?('POO ruby')
    assert page.has_content?('Android Studio Curso')
    assert page.has_content?('Rails as a Day to Day')
    assert page.has_content?('POO Java')
    assert page.has_content?('POO Kotlin')
  end

  test 'judge user can validate a location' do
    activity = activities(:activity_talk)

    visit match_judge_activity_path(@match, activity)
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/locations/#{activity.locations.first.id}']").click
    assert page.has_content?(I18n.t('labels.location_approved'))
  end

  test 'judge can unapprove an activity location' do
    activity = activities(:activity_workshop)

    visit match_judge_activity_path(@match, activity)
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/locations/#{activity.locations.first.id}']").click
    assert page.has_content?(I18n.t('labels.location_unapproved'))
  end

  test 'judge can leave a comment on the activity' do
    activity = activities(:activity_workshop)

    visit match_judge_activity_path(@match, activity)
    fill_in 'feedback[comment]', with: 'Looks like this is a fantastic activity'
    find('input[name="commit"]').click

    assert page.has_content?(I18n.t('comments.created'))
  end

  test 'judge can edit a comment' do
    activity = activities(:activity_workshop)

    visit match_judge_activity_path(@match, activity)
    fill_in 'feedback[comment]', with: 'Looks like this is a fantastic activity'
    find('input[name="commit"]').click
    page.find("a[href='#']", visible: :all).click
    fill_in 'editor_0', with: 'Looks like this is amazing'
    page.find("a[href='#']", visible: :all).click

    assert page.has_content?('Looks like this is amazing')
  end
end

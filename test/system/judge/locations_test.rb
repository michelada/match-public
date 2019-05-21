require 'application_system_test_case'

class LocationsTest < ApplicationSystemTestCase
  def setup
    login_as users(:judge_user)
    Match.last.destroy
    @match = matches(:active_content_match)
    @match.poll.update_attributes(start_date: Date.today)
  end

  test 'judge user can validate a location' do
    activity = activities(:activity_talk)

    visit match_activity_path(@match, activity)
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/locations/#{activity.locations.first.id}']").click
    assert page.has_content?(I18n.t('labels.location_approved'))
  end

  test 'judge can unapprove an activity location' do
    activity = activities(:activity_workshop)

    visit match_activity_path(@match, activity)
    find("a[href='/match/#{@match.id}/judge/activities/#{activity.slug}/locations/#{activity.locations.first.id}']").click
    assert page.has_content?(I18n.t('labels.location_unapproved'))
  end
end

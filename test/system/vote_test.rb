require 'application_system_test_case'

class VoteTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_in_match)
    login_as @user
    Match.last.destroy
    @match = matches(:content_match)
  end

  test 'user can vote for an activity' do
    visit match_poll_path(@match, @match.poll)
    activity = activities(:activity_workshop)

    find("a[href='/match/#{@match.id}/polls/#{@match.poll.id}/activities/#{activity.slug}/votes']").click
    assert page.has_content?(I18n.t('votes.voted'))
  end

  test 'user can delete its vote for an activity' do
    visit match_poll_path(@match, @match.poll)
    vote = votes(:java_vote)
    activity = activities(:activity_post)
    find("a[href='/match/#{@match.id}/polls/#{@match.poll.id}/activities/#{activity.slug}/votes/#{vote.id}']").click
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('votes.unvoted'))
  end
end

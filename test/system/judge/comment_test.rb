require 'application_system_test_case'

class CommentTest < ApplicationSystemTestCase
  def setup
    login_as users(:judge_user)
    Match.last.destroy
    @match = matches(:active_content_match)
    @match.poll.update_attributes(start_date: Date.today)
  end

  test 'judge can leave a comment on the activity' do
    activity = activities(:activity_workshop)

    visit match_activity_path(@match, activity)
    fill_in 'feedback[comment]', with: 'Looks like this is a fantastic activity'
    find('input[name="commit"]').click

    assert page.has_content?(I18n.t('comments.created'))
  end

  test 'judge can edit a comment' do
    activity = activities(:activity_workshop)

    visit match_activity_path(@match, activity)
    fill_in 'feedback[comment]', with: 'Looks like this is a fantastic activity'
    find('input[name="commit"]').click
    page.find("a[href='#']", visible: :all).click
    fill_in 'editor_0', with: 'Looks like this is amazing'
    page.find("a[href='#']", visible: :all).click

    assert page.has_content?('Looks like this is amazing')
  end
end

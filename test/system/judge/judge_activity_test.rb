require 'application_system_test_case'

class JudgeActivityTest < ApplicationSystemTestCase
  def setup
    login_as users(:judge_user)
    Match.last.destroy
    @match = matches(:active_content_match)
    @match.poll.update_attributes(start_date: Date.today)
  end

  test 'judge can see only waiting activities on the on wait section' do
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
end

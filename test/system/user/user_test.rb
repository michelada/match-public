require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  def setup
    Match.last.destroy
    @match = matches(:active_content_match)
  end

  test 'user can see top 3 label in main view' do
    @team_user = users(:user_with_team)
    sign_in @team_user

    visit match_main_index_path(@match)
    assert page.has_content?('Top 3')
    assert page.has_content?('ActualTeam')
  end
end

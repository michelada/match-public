require 'application_system_test_case'

class JudgeTest < ApplicationSystemTestCase
  def setup
    Match.last.destroy
    @match = matches(:active_content_match)
  end

  test 'judge can visit her main menu' do
    login_as users(:judge_user)
    visit match_main_index_path(@match)
  end
end

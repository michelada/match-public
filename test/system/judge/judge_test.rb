require 'application_system_test_case'

class JudgeTest < ApplicationSystemTestCase
  def setup
    Match.last.destroy
    @match = matches(:active_content_match)
  end

  test 'judge can visit her main menu' do
    @judge = users(:judge_user)
    login_as @judge
    visit match_main_index_path(@match)
  end
end

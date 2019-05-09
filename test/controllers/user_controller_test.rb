require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_test1)
    @match = Match.last
    sign_in @user
  end

  test 'user can leave a team' do
    patch match_user_path(@match, @user.id), params: { user: { id: @user.id } }
    assert_redirected_to match_main_index_path(@match), 'Unexpected controller response'
    assert_equal flash[:notice], I18n.t('team.messages.left')
    assert_nil @user.current_team, 'User has team'
  end
end

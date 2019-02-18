require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_test1)
    sign_in @user
  end

  test 'user can leave a team' do
    patch user_path(@user.id), params: { user: { id: @user.id } }
    assert_redirected_to main_index_path, 'Unexpected controller response'
    assert_equal flash[:notice], I18n.t('team.messages.leaved')
    assert_nil @user.team, 'User has team'
  end
end

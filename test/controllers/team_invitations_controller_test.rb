require 'test_helper'
require 'pry'

class TeamInvitationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_test1)
    login_as @user
    @match = Match.last
  end

  test 'user can not invite with an invalid email' do
    post match_team_invitations_path(@match, @user.team), params: {
      email: 'example_user@michelado.io'
    }

    assert_equal flash[:alert], I18n.t('team.invalid_user')
  end

  test 'user can invite a new user' do
    post match_team_invitations_path(@match, @user.team), params: {
      email: 'miguel.urbina@michelada.io'
    }

    assert_equal flash[:notice], I18n.t('team.messages.user_invited')
  end

  test 'user can invite a user with no team' do
    user = users(:user)

    post match_team_invitations_path(@match, @user.team), params: {
      email: user.email
    }

    assert_equal flash[:notice], I18n.t('team.messages.user_invited')
  end

  test 'user can not invite if the team already have 3 members' do
    user = users(:user_test2)
    @user.team = teams(:team2)
    @user.save!

    post match_team_invitations_path(@match, user.team), params: {
      email: 'miguel.urbina@michelada.io'
    }

    assert_equal flash[:alert], I18n.t('team.messages.error_inviting')
  end

  test 'user can not invite a user if he/she already has a team' do
    user = users(:user_test2)

    post match_team_invitations_path(@match, @user.team), params: {
      email: user.email
    }

    assert_equal flash[:alert], I18n.t('team.invalid_user')
  end
end

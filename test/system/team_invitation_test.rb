require 'application_system_test_case'

class TeamInvitationTest < ApplicationSystemTestCase
  before do
    @match = matches(:content_match)
  end

  test 'user without team can view the opcion create a new team' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
  end

  test 'user can create a dynasty in create a new team' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    click_button 'Crear'
  end

  test 'user only can view the option to create a dynasty' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    assert has_button?(I18n.t('buttons.create'))
  end

  test 'user can invite someone when creating a new team' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    fill_in 'user_invitations[email_1]', with: 'miguel.urbina@michelada.io'

    click_button 'Crear'
    assert page.has_content?(I18n.t('team.messages.created'))
  end

  test 'user can invite someone when do not have a account' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    fill_in 'user_invitations[email_1]', with: 'juventus@michelada.io'

    click_button 'Crear'
    assert page.has_content?(I18n.t('team.messages.created'))
  end

  test 'user can invite two users when creating a new team' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    fill_in 'user_invitations[email_1]', with: 'miguel.urbina@michelada.io'
    fill_in 'user_invitations[email_2]', with: 'luis.brizu@michelada.io'

    click_button 'Crear'
    assert page.has_content?(I18n.t('team.messages.created'))
  end

  test 'user can invite someone through invitation view' do
    user = users(:user_test2)
    sign_in user

    visit new_match_team_invitation_path(@match)
    fill_in 'email', with: 'miguel.urbina@michelada.io'

    click_button 'Enviar invitación'
  end

  test 'user can not invite an a user with team' do
    user = users(:user_test2)
    use2 = users(:user_with_teammates2)
    sign_in user

    visit new_match_team_invitation_path(@match)
    fill_in 'email', with: use2.email

    click_button 'Enviar invitación'
    assert page.has_content?(I18n.t('team.invalid_user'))
  end

  test 'user can not invite someone with an invalid email when creating a team' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    fill_in 'user_invitations[email_1]', with: 'miguel.urbina@mich.io'

    click_button 'Crear'
    assert page.has_content?(I18n.t('team.messages.error_users'))
  end

  test 'user can not invite someone with an invalid email through invitation view' do
    user = users(:user)
    sign_in user

    visit new_match_team_path(@match)
    fill_in 'user_invitations[email_1]', with: 'miguel.urbina@michelado.io'

    click_button 'Crear'
    assert page.has_content?(I18n.t('team.messages.error_users'))
  end

  test 'user can see the link and go to the invitation view.' do
    user = users(:user_in_match)
    active_match = matches(:active_content_match)
    sign_in user
    visit match_team_path(active_match, user.team)

    assert page.find(:css, "a[href='/match/#{active_match.id}/team_invitations/new']")
  end
end

require 'application_system_test_case'

class TeamTest < ApplicationSystemTestCase

  test 'Users can invite another user at the team' do
    @team_user = users(:user_with_team)
    sign_in @team_user
    visit new_team_path
    click_link 'Agregar integrante'
    fill_in 'user[email]', with: 'test90@michelada.io'
   #click_button 'Enviar invitación'
  end

  test 'Users can not invite another user at the team when the team is full' do
    @team_user = users(:user_with_teammates)
    sign_in @team_user
    visit new_team_path
    assert has_no_link?('Agregar integrante')
  end

  test 'if the team is not complete the page sample a link' do
    @team_user = users(:user_with_team)
    sign_in @team_user
    visit new_team_path
    assert has_link?('Agregar integrante')
  end
end

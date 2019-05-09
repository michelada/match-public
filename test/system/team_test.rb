require 'application_system_test_case'

class TeamTest < ApplicationSystemTestCase
  def setup
    Match.last.destroy
    @match = matches(:active_content_match)
  end

  test 'Users can invite another user at the team' do
    @team_user = users(:user_in_match)

    sign_in @team_user
    visit new_match_team_path(@match)
    click_link 'Agregar integrante'
    fill_in 'email', with: 'test90@michelada.io'
    click_button 'Enviar invitación'
  end

  test 'Users can not invite another user at the team when the team is full' do
    @team_user = users(:user_with_teammates)
    sign_in @team_user
    visit new_match_team_path(@match)
    assert has_no_link?('Agregar integrante')
  end

  test 'if the team is not complete the page sample a link' do
    @team_user = users(:user_in_match)
    sign_in @team_user
    visit new_match_team_path(@match)
    assert has_link?('Agregar integrante')
  end
end

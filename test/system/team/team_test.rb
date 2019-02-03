require 'application_system_test_case'

class TeamTest < ApplicationSystemTestCase
  before do
    @team_user = users(:user_with_team)
    sign_in @team_user
  end



  test 'Users can invite another user at the team' do
    visit new_team_path
    click_link 'Agregar integrante'
    fill_in 'user[email]', with: 'test90@michelada.io'
    click_button 'Enviar invitación'
  end


  def create_simple_acitivy
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[locations]', with: 'Test location' 
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'
  end

  def create_multiple_activities
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    3.times do |i|
      fill_in 'activity[locations]', with: "Test_location_#{i + 1}"
      find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    end
    click_button 'Enviar'
  end
end

require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    @team_user = users(:user_with_team)
    sign_in @team_user
    Match.last.destroy
    @match = matches(:active_content_match)
    @team_user.teams.last.update_attributes(match: Match.last)
  end

  test 'Users can create a new location from new_activity view' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    assert page.has_content?('Test location')
  end

  test 'Users cant add the same location twice ' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'add_location_input', with: 'Test location'
    find(:css, "input[id$='add_location_input']").native.send_keys(:enter)
    message = accept_alert
    assert_equal message, 'Esta opción ya ha sido seleccionada'
  end

  test 'Users can create a new location when editing an activity' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'add_location_input', with: 'Example location2'
    find(:css, "input[id$='add_location_input']").native.send_keys(:enter)
    click_button 'Enviar'

    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click

    assert page.has_content?('Example location2')
  end

  def create_simple_activity
    visit new_match_activity_path(@match)
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[description]', with: 'Test location'
    fill_in 'activity[pitch_audience]', with: 'Test location'
    fill_in 'activity[abstract_outline]', with: 'Test location'

    fill_in 'add_location_input', with: 'Test location'
    find(:css, "input[id$='add_location_input']").native.send_keys(:enter)
    click_button 'Enviar'
  end
end

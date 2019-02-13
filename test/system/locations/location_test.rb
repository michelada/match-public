require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    @team_user = users(:user_with_team)
    sign_in @team_user
  end

  test 'Users can create a new location from new_activity view' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    assert_equal true, page.has_content?('Test location')
  end

  test 'Users cant add the same location twice ' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'activity[locations]', with: 'Test location'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    message = accept_alert
    assert_equal message, 'El elemento que tratas de agregar ya está en la lista'
  end

  test 'Users can create a new location when editing an activity' do
    create_simple_activity
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'activity[locations]', with: 'Example location2'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'

    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click

    assert_equal true, page.has_content?('Example location')
  end

  def create_simple_activity
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[description]', with: 'Test location'
    fill_in 'activity[pitch_audience]', with: 'Test location'
    fill_in 'activity[abstract_outline]', with: 'Test location'
    fill_in 'activity[locations]', with: 'Test location'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'
  end
end

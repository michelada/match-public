require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    @team_user = users(:user_with_team)
    sign_in @team_user
  end

  test 'Users can create a new location from new_activity view' do
    create_simple_acitivy
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    assert_equal true, page.has_content?('Test location')
  end

  test 'Users cant add the same location twice ' do
    create_simple_acitivy
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'activity[locations]', with: 'Test location'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    message = accept_alert
    assert_equal message, 'El elemento que tratas de agregar ya está en la lista'
  end

  test 'Users can create a new location when editing an activity' do
    create_simple_acitivy
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click
    fill_in 'activity[locations]', with: 'Example location2'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'

    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click

    assert_equal true, page.has_content?('Example location')
  end

  test 'Users can dismiss a selected location when creating a new activity' do
    create_multiple_activities
    accept_alert do
      find(:css, 'img[src*="/assets/ic-delete-57cf761d141b78b36bd8779c19e42ef534dd63fd1dd47b1b942d74f6e9ffde26.svg').click
    end
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test 2'
    3.times do |i|
      fill_in 'activity[locations]', with: "Test_location_#{i + 1}"
      find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    end

    click_button 'Enviar'
    find(:css, 'img[src*="/assets/ic-edit-2ceeb8e85845ac2f003993010690b1ae7205f737bec2f021547c8b1fc3879688.svg"]').click

    assert_equal true, page.has_content?('Test_location_2')
    assert_equal true, page.has_content?('Test_location_3')
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

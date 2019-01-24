require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    @user = users(:user)
    sign_in @user
  end

  test 'Users can create a new location from new_activity view' do
    create_simple_acitivy
    click_link 'Editar'
    assert_equal true, page.has_content?('Test location')
  end

  test 'Users cant add the same location twice (from select menu)' do
    create_simple_acitivy
    click_link 'Editar'
    select('Test location', from: 'activity[locations]')
    message = accept_alert do
      click_link 'Agregar'
    end
    assert_equal message, "The element you're tryng to add is already on the list"
  end

  test 'Users cant add the same location twice (from other_location text input)' do
    create_simple_acitivy
    click_link 'Editar'
    fill_in 'activity[locations]', with: 'Test location'
    message = accept_alert do
      click_link 'Agregar otro'
    end
    assert_equal message, "The element you're tryng to add is already on the list"
  end

  test 'Users can create a new location when editing an activity' do
    create_simple_acitivy
    click_link 'Editar'
    fill_in 'activity[locations]', with: 'Example location2'
    click_link 'Agregar otro'
    click_button 'Enviar'

    click_link 'Editar'

    assert_equal true, page.has_content?('Example location')
  end

  test 'Users can dismiss a selected location when creating a new activity' do
    create_multiple_activities
    accept_alert do
      click_link 'Eliminar'
    end
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test 2'
    3.times do |i|
      select("Test_location_#{i + 1}", from: 'activity[locations]')
      click_link 'Agregar'
    end

    find_button(id: 1000).click
    click_button 'Enviar'
    click_link 'Editar'

    assert_equal true, page.has_content?('Test_location_2')
    assert_equal true, page.has_content?('Test_location_3')
  end

  def create_simple_acitivy
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[locations]', with: 'Test location'
    click_link 'Agregar otro'
    click_button 'Enviar'
  end

  def create_multiple_activities
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    3.times do |i|
      fill_in 'activity[locations]', with: "Test_location_#{i + 1}"
      click_link 'Agregar otro'
    end
    click_button 'Enviar'
  end
end

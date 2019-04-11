require 'application_system_test_case'

class ActivityTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_with_teammates)
    login_as @user
  end

  test 'user can upload an activity' do
    Poll.delete_all
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[description]', with: 'Test location'
    fill_in 'activity[pitch_audience]', with: 'Test location'
    fill_in 'activity[abstract_outline]', with: 'Test location'

    fill_in 'add_location_input', with: 'Test location'
    find(:css, "input[id$='add_location_input']").native.send_keys(:enter)
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    assert page.has_content?('Test')
  end

  test 'user can edit an activity' do
    visit team_path(@user.team)
    within('.activities-table') do
      find("a[href='/activities/rails-as-a-day-to-day/edit']").click
    end
    fill_in 'activity[name]', with: 'Django as a Day to Day'
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.updated'))
    assert page.has_content?('Django as a Day to Day')
  end

  test 'user can delete an activity' do
    visit team_path(@user.team)
    within('.activities-table') do
      find("a[href='/activities/rails-as-a-day-to-day'][data-method='delete']").click
    end
    page.driver.browser.switch_to.alert.accept
    assert page.has_content?(I18n.t('activities.messages.deleted'))
  end
end

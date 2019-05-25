require 'application_system_test_case'

class ActivityTest < ApplicationSystemTestCase
  def setup
    @user = users(:user_in_match)
    @user.activities << activities(:ruby_as_day_to_day)
    login_as @user
    Match.last.destroy
    @match = matches(:content_match)
    @active_match = matches(:active_content_match)
  end

  test 'user can upload an activity with images and PDF' do
    Poll.delete_all

    visit new_match_activity_path(@active_match)
    fixture_files_path = "#{Rails.root}/test/fixtures/files/"

    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[description]', with: 'Test location'
    fill_in 'activity[pitch_audience]', with: 'Test location'
    fill_in 'activity[abstract_outline]', with: 'Test location'
    attach_file 'activity[files][]', [fixture_files_path + 'Curso introductorio Android Studio.pdf',
                                      fixture_files_path + 'evidence.png']
    fill_in 'add_location_input', with: 'Test location'
    find(:css, "input[id$='add_location_input']").native.send_keys(:enter)
    fill_in 'activity[notes]', with: 'https://www.google.com/'
    click_button 'Enviar'

    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    assert page.has_content?('Test')
  end

  test 'user can not create an activity if fields are empty' do
    visit new_match_activity_path(@active_match)
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activerecord.errors.models.activity.attributes.name.blank'))
    assert page.has_content?(I18n.t('activerecord.errors.models.activity.attributes.description.blank'))
    assert page.has_content?(I18n.t('activerecord.errors.models.activity.attributes.abstract_outline.blank'))
    assert page.has_content?(I18n.t('activerecord.errors.models.activity.attributes.pitch_audience.blank'))
    assert page.has_content?(I18n.t('activities.messages.error_creating'))
  end

  test 'user can select english' do
    visit new_match_activity_path(@active_match)
    select 'Post', from: 'activity[activity_type]'
    fill_in 'activity[name]', with: 'EN'
    find(:css, "#activity_english[value='1']").set(true)
    assert page.has_checked_field?('activity_english')
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    visit match_teams_path(@active_match)
    assert page.has_content?('EN')
    click_link 'EN'
    assert page.has_content?(I18n.t('labels.english'))
  end

  test 'user can create a post' do
    visit new_match_activity_path(@active_match)
    select 'Post', from: 'activity[activity_type]'
    fill_in 'activity[name]', with: 'Post'
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    visit match_teams_path(@active_match)
    assert page.has_content?('Post')
  end

  test 'user can create a talk' do
    visit new_match_activity_path(@active_match)
    select 'Plática', from: 'activity[activity_type]'
    fill_in 'activity[name]', with: 'Talk'
    fill_in 'activity[description]', with: 'Test'
    fill_in 'activity[pitch_audience]', with: 'Test'
    fill_in 'activity[abstract_outline]', with: 'Test'
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    visit match_teams_path(@active_match)
    assert page.has_content?('Talk')
  end

  test 'user can create a course' do
    visit new_match_activity_path(@active_match)
    select 'Curso', from: 'activity[activity_type]'
    fill_in 'activity[name]', with: 'Course'
    fill_in 'activity[description]', with: 'Test'
    fill_in 'activity[pitch_audience]', with: 'Test'
    fill_in 'activity[abstract_outline]', with: 'Test'
    click_button 'Enviar'
    assert page.has_content?(I18n.t('activities.messages.uploaded'))
    visit match_teams_path(@active_match)
    assert page.has_content?('Course')
  end

  test 'user can edit an activity' do
    visit match_team_path(@active_match, @user.current_team)

    within('.activities-table') do
      find("a[href='/match/#{@active_match.id}/activities/rails-as-a-day-to-day/edit']").click
    end
    fill_in 'activity[name]', with: 'Django as a Day to Day'
    click_button 'Enviar'

    assert page.has_content?(I18n.t('activities.messages.updated'))
    assert page.has_content?('Django as a Day to Day')
  end

  test 'user can delete an activity' do
    visit match_team_path(@match, @user.current_team)
    activity = activities(:ruby_as_day_to_day)

    within('.activities-table') do
      find("a[href='/match/#{@match.id}/activities/#{activity.slug}'][data-method='delete']").click
    end
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('activities.messages.deleted'))
  end

  test 'user can delete a file from activity edition' do
    activity = activities(:ruby_as_day_to_day)
    activity.update_attributes(user: @user)
    activity.files.attach(io: File.open("#{Rails.root}/test/fixtures/files/evidence.png"),
                          filename: 'evidence.png',
                          content_type: 'image/png')
    activity.save!
    file = activity.files.first

    visit edit_match_activity_path(@match, activity)
    find("a[href='/activities/#{activity.id}/uploads/#{file.id}']").click
    page.driver.browser.switch_to.alert.accept

    assert page.has_content?(I18n.t('uploads.deleted'))
  end
end

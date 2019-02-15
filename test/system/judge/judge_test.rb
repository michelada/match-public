require 'application_system_test_case'

class JudgeTest < ApplicationSystemTestCase
  test 'Judge can validate an activity' do
    create_simple_activity
    @judge = users(:judge_user)
    sign_in @judge
    visit judge_main_index_path
    activity = Activity.find_by(name: 'Test')
    within "#activity_#{activity.id}" do
      find("#go_to_#{activity.id}").click
    end
    click_link 'Aprobar'
    assert has_content?('Desaprobar')
  end

  test 'Judge can comment an activity' do
    create_simple_activity
    @judge = users(:judge_user)
    sign_in @judge
    visit judge_main_index_path
    activity = Activity.find_by(name: 'Test')
    within "#activity_#{activity.id}" do
      find("#go_to_#{activity.id}").click
    end
    fill_in 'feedback[comment]', with: 'Test comment'
    click_button 'Comentar'
    assert has_content?('JUDGE_USER')
    assert has_content?('Test comment')
  end

  def create_simple_activity
    user_with_team = users(:user_with_team)
    sign_in user_with_team
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[description]', with: 'Test location'
    fill_in 'activity[pitch_audience]', with: 'Test location'
    fill_in 'activity[abstract_outline]', with: 'Test location'
    fill_in 'activity[locations]', with: 'Test location'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'
    click_link 'Cerrar sesión'
  end
end

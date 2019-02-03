require 'application_system_test_case'

class JudgeTest < ApplicationSystemTestCase
  test 'Judge can validate an activity' do
    create_simple_acitivy
    @judge = users(:judge_user)
    sign_in @judge
    visit judge_main_index_path
    click_link 'Test'
    click_link 'Aprobar'
    assert has_content?('En revisión')
  end

  test 'Judge can comment an activity' do
    create_simple_acitivy
    @judge = users(:judge_user)
    sign_in @judge
    visit judge_main_index_path
    click_link 'Test'
    fill_in 'feedback[comment]', with: 'Test comment'
    click_button 'Comentar'
    assert has_content?('judge_user@michelada.io')
    assert has_content?('Test comment')
  end

  def create_simple_acitivy
    @team_user = users(:user_with_team)
    sign_in @team_user
    visit new_activity_path
    fill_in 'activity[name]', with: 'Test'
    fill_in 'activity[locations]', with: 'Test location'
    find(:css, "input[id$='activity_locations']").native.send_keys(:enter)
    click_button 'Enviar'
    visit new_team_path
    click_link 'Cerrar sesión'
  end
end

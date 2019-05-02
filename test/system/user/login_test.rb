require 'application_system_test_case'

class LoginTest < ApplicationSystemTestCase
  def setup
    Match.last.destroy
    @match = matches(:active_content_match)
  end

  test 'user can login with a valid account' do
    @user = users(:user)
    login_as @user
  end

  test 'the first view of the user is invite collabortors' do
    @user = users(:user)
    login_as @user

    visit new_match_team_path(@match)
    assert_equal(current_path, new_match_team_path(@match))
  end

  test 'if the user forgot his password he can change using the option forget password' do
    visit new_user_session_path

    click_link I18n.t('user.forgot_password')
    assert_equal(current_path, new_user_password_path)

    fill_in 'user[email]', with: 'normal_user@michelada.io'
    click_button 'Enviar instrucciones'
  end

  test 'the app only accept domain michelada.io' do
    visit new_user_registration_path

    fill_in 'user[email]', with: 'new_normal_user@michelada.io'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Registrarse'
  end

  test 'the app do not accept another domain' do
    visit new_user_registration_path

    fill_in 'user[email]', with: 'normal_user@gmail.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'

    click_button 'Registrarse'
    assert page.has_content?(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
  end

  test 'user can logout' do
    @user = users(:user)
    login_as @user
    visit new_match_team_path(@match)
    click_link I18n.t('user.log_out')
    assert_equal(current_path, root_path)
  end
end

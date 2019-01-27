require 'test_helper'
module Admin
  class UserManagerControllerTest < ActionDispatch::IntegrationTest
    test 'no logged user can not visit admin page' do
      get admin_user_manager_index_path
      assert_redirected_to new_user_session_path, 'Controller response unexpected'
    end

    test 'normal user can not  accees to admin page' do
      user = users(:user)
      sign_in user
      get admin_user_manager_index_path
      assert_redirected_to root_path, 'Controller response unexpected'
    end

    test 'judge user can not visit admin page' do
      judge_user = users(:judge_user)
      sign_in judge_user
      get admin_user_manager_index_path
      assert_redirected_to root_path, 'Controller response unexpected'
    end

    test 'admin user can visit admin page' do
      admin_user = users(:admin_user)
      sign_in admin_user
      get admin_user_manager_index_path
      assert_response :success
    end

    test 'admin user can change a user role' do
      admin_user = users(:admin_user)
      sign_in admin_user
      normal_user = users(:user)
      put admin_user_manager_path(normal_user.id), params: { user: { role: 'judge' }, id: normal_user.id }
      assert_redirected_to admin_user_manager_index_path
      assert flash[:notice] = I18n.t('user.role_updated')
    end
  end
end

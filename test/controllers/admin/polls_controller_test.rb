require 'test_helper'
module Admin
  class PollsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @admin_user = users(:admin_user)
      Poll.delete_all
      @match = Match.last
    end

    test 'no logged user can no acces to poll index' do
      get admin_match_polls_path(@match)
      assert_redirected_to new_user_session_path, 'Controller response unexpected'
    end

    test 'no admin users can no acces to poll index' do
      user = users(:user)
      sign_in user
      get admin_match_polls_path(@match)
      assert_redirected_to root_path
    end

    test 'admin user is redirectet to new poll creation when visit polls path and has no polls registered' do
      sign_in @admin_user
      get admin_match_polls_path(@match)
      assert_redirected_to new_admin_match_poll_path(@match)
    end

    test 'admin user can create a poll' do
      sign_in @admin_user
      post admin_match_polls_path(@match), params: { poll: { start_date: Date.today, end_date: Date.today + 2.weeks,
                                                             activities_from: '2019-09-10',
                                                             activities_to: '2019-01-01' } }
      assert_redirected_to admin_match_polls_path
      assert_equal flash[:notice], I18n.t('poll.created')
    end

    test 'admin can not create a poll without a date' do
      sign_in @admin_user
      post admin_match_polls_path(@match), params: { poll: { start_date: '2019-02-10',
                                                             end_date: '2019-04-10',
                                                             activities_from: '2019-01-10',
                                                             activities_to: '' } }
      assert_response :success
      assert_equal flash[:alert], I18n.t('poll.error_creating')
    end
  end
end

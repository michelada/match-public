require 'test_helper'

class MatchControllerTest < ActionDispatch::IntegrationTest
  def setup
    @match = matches(:content_match)
    @user = users(:admin_user)
  end

  test 'no logged user can not visit admin match page' do
    get admin_matches_path
    assert_redirected_to new_user_session_path
  end

  test 'admin can view a match information' do
    sign_in @user
    get admin_match_path(@match)
    assert_response :success
  end

  test 'user can create a match with all data' do
    sign_in @user

    post admin_matches_path, params: { match: { start_date: Date.today + 10.days,
                                                end_date: Date.today + 13.days,
                                                match_type: 'Content' } }

    assert_redirected_to admin_matches_path
    assert_equal I18n.t('match.create'), flash[:notice]
  end

  test 'user can not create a match without match_type' do
    sign_in @user

    post admin_matches_path, params: { match: { start_date: Date.today + 10.days,
                                                end_date: Date.today + 13.days } }

    assert_response :success
    assert_equal I18n.t('match.error_creating'), flash[:alert]
  end

  test 'user can update a match ' do
    match = matches(:active_content_match)
    sign_in @user

    patch admin_match_path(match), params: { match: { start_date: Date.today + 12.days,
                                                      end_date: Date.today + 14.days,
                                                      match_type: 'Content' } }

    assert_redirected_to admin_matches_path
    assert_equal flash[:notice], I18n.t('match.update')
  end
end

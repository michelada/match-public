require 'test_helper'

class MatchControllerTest < ActionDispatch::IntegrationTest
  def setup
    @match = matches(:content_match)
    @user = users(:admin_user)
    @match_params = { match: { start_date: Date.today + 10.days,
                               end_date: Date.today + 13.days,
                               match_type: 'Content' } }
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

    post admin_matches_path, params: @match_params

    assert_redirected_to admin_matches_path
    assert_equal I18n.t('match.create'), flash[:notice]
  end

  test 'user can not create a match without match_type' do
    sign_in @user

    @match_params[:match].delete(:match_type)
    post admin_matches_path, params: @match_params

    assert_response :success
    assert_equal I18n.t('activerecord.errors.models.match.attributes.match_type.blank'), flash[:alert]
  end

  test 'user can update a match ' do
    match = matches(:active_content_match)
    sign_in @user

    @match_params[:match][:start_date] = Date.today + 20.days
    @match_params[:match][:end_date] = Date.today + 30.days
    patch admin_match_path(match), params: @match_params
    assert_redirected_to admin_matches_path
    assert_equal flash[:notice], I18n.t('match.update')
  end
end

require 'test_helper'

class TeamControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get team_new_url
    assert_response :success
  end
end

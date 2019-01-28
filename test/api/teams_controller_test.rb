require 'test_helper'

module Api
  class TeamsControllerTest < ActionDispatch::IntegrationTest
    test 'Compare teams API with the fetched response' do
    get api_teams_path
    assert_response :success
    top_five_teams = Team.obtain_top_five_teams
    json_response = JSON.parse(response.body)
    assert_equal top_five_teams[0].name, json_response['data'][0]['name']
    assert_equal top_five_teams[0].score, json_response['data'][0]['value']
    end
  end
end
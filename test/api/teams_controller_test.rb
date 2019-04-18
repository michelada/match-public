require 'test_helper'

module Api
  class TeamsControllerTest < ActionDispatch::IntegrationTest
    test 'Compare teams API with the fetched response' do
      get api_teams_path
      assert_response :success

      top_five_teams = Poll.last.teams_by_score.limit(5)
      json_response = JSON.parse(response.body)
      assert_equal top_five_teams[0].name, json_response['data'][0]['name']
      assert_equal top_five_teams[0].total_score, json_response['data'][0]['value']
    end
  end
end

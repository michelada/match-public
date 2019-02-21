require 'test_helper'

module Api
  class ActivitiesControllerTest < ActionDispatch::IntegrationTest
    test 'Compare activities API with the fetched response' do
      get api_activities_path
      assert_response :success
      last_activity = Activity.last
      json_response = JSON.parse(response.body)
      assert_equal last_activity.name, json_response['data']['value']
    end
  end
end

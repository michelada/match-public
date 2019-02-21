require 'test_helper'

module Api
  class ActivitiesControllerTest < ActionDispatch::IntegrationTest
    test 'Compare activities API with the fetched response' do
      get api_activities_path
      assert_response :success
      @last_activity = activities(:activity2)
      json_response = JSON.parse(response.body)
      assert_equal @last_activity.name, json_response['data']['value']
    end

    test 'API without Activities' do
      Activity.all.each(&:destroy)
      get api_activities_path
      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal 'No activities yet', json_response['data']['value']
    end
  end
end

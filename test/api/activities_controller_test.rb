require 'test_helper'

module Api
  class ActivitiesControllerTest < ActionDispatch::IntegrationTest
    test 'Compare activities API with the fetched response' do
      Match.last.destroy
      get api_activities_path
      assert_response :success
      last_activity = Activity.last
      json_response = JSON.parse(response.body)
      assert_equal last_activity&.name, json_response['data']['value']
    end

    test 'When mcm does not have activities it display a No activities message' do
      Match.last.destroy
      Activity.destroy_all
      get api_activities_path
      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal I18n.t('api.errors.no_activities'), json_response['data']['value']
    end

    test 'When match is not mcm it display a No activities in this match message' do
      get api_activities_path
      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal I18n.t('api.errors.no_content_match'), json_response['data']
    end
  end
end

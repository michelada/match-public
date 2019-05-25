require 'test_helper'

class UploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity = activities(:ruby_as_day_to_day)
    @activity.files.attach(io: File.open("#{Rails.root}/test/fixtures/files/evidence.png"), filename: 'evidence.png', content_type: 'image/png')
    @activity.save!
    @file = @activity.files.first
    @match = @activity.match
  end

  test 'user can destroy file from activity' do
    user = users(:user_with_teammates)
    login_as user
    delete activity_upload_path(@activity.id, @file.id), headers: { HTTP_REFERER: match_activity_path(@match, @activity) }

    assert_response :redirect
    assert_equal I18n.t('uploads.deleted'), flash[:notice]
  end

  test 'no user activity owner can delete a file' do
    user = users(:user)
    login_as user
    delete activity_upload_path(@activity.id, @file.id), headers: { HTTP_REFERER: match_activity_path(@match, @activity) }

    assert_response :redirect
    assert_equal I18n.t('activities.messages.no_permitted'), flash[:alert]
  end

  test 'no looged users can not delete files' do
    delete activity_upload_path(@activity.id, @file.id), headers: { HTTP_REFERER: match_activity_path(@match, @activity) }

    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
end

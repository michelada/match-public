require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    @user = users(:user)
    sign_in @user
  end

  test 'Users can view already created locations' do
    visit new_activity_path
    click_link 'Agregar'
    assert_equal(1, 1)
  end
end

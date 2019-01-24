require 'application_system_test_case'

class LocationTest < ApplicationSystemTestCase
  before do
    visit teams
  end

  test( 'Users can view a information for a teams json') do
    assert_equal true, page.has_content?("Test location")
  end
end
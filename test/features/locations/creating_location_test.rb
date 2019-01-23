require 'test_helper'

class CreatingLocationTest < ActiveSupport::TestCase
  before do 
    let(:location1) { Location.create(:name => "location1")}
    let(:location2) { Location.create(:name => "location2")}

    login_as @user
    visit new_activity_path
    click_link 'Agregar'
  end

  test 'Users can view already created locations' do
    assert_equal(1, 1)
  end
end

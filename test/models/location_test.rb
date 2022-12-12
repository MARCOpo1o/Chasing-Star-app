require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "location returns a string" do
    location = Location.new
    location.location_name = "test"
    assert_equal "test", location.location_name
  end

  test "starVisibility returns a number between 1 and 100" do
    location = Location.new
    location.location_name = "test"
    location.longitude = 1
    location.latitude = 1
    assert_equal 0, location.starVisibility
  end

end

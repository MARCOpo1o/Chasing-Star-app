require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "location returns a string" do
    location = Location.new
    location.location_name = "test"
    assert_equal "test", location.location_name
  end

end

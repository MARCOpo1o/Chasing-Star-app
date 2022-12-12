require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "location returns a string" do
    location = Location.new
    location.location_name = "test"
    assert_equal "test", location.location_name
  end

  test "bortleScale returns nil before initiating" do
    location = Location.new
    assert_nil location.bortleScale
  end

  test "bortleScale returns a number after initiating" do
    location = Location.new
    location.bortleScale = 5
    assert_equal 5, location.bortleScale
  end

  def setup 
    @location = locations(:waltham)
  end

  test "location should be valid" do
    assert @location.valid?
  end

end

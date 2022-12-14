require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = locations(:waltham)
    @admin
  end

  test "should get index" do
    get locations_url
    assert_response :success
  end

  test "should get new" do
    get new_location_url
    assert_response :success
  end

  test "should create location" do
    assert_difference("Location.count") do
      post locations_url, params: { location: { location_name: @location.location_name, average_rate: 3.0 } }
    end 

    assert_redirected_to location_url(Location.last)
  end

  # need to add api stuff
  # test "should show location" do
  #   get location_url(@location)
  #   assert_response :success
  # end

  test "should update location" do
    patch location_url(@location), params: { location: { location_name: @location.location_name, average_rate: 3.0 } }
    assert_redirected_to location_url(@location)
  end

  test "should destroy location" do
    assert_difference("Location.count", -1) do
      delete location_url(@location)
    end

    assert_redirected_to locations_url
  end
end

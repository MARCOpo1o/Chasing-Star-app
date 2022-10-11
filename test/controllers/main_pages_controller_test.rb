require "test_helper"

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get main_pages_home_url
    assert_response :success
  end

  test "should get explore" do
    get main_pages_explore_url
    assert_response :success
  end
end

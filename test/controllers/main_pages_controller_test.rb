require "test_helper"

class MainPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get explore" do
    get explore_path
    assert_response :success
  end
end

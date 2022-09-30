require "test_helper"

class AlgorithmControllerTest < ActionDispatch::IntegrationTest
  test "should get simple" do
    get algorithm_simple_url
    assert_response :success
  end
end

require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @location = locations(:waltham)
    @post = Post.new(message: "test", rate:3, user_id: @user.id, location_id: @location.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "location id should be present" do
    @post.location_id = nil
    assert_not @post.valid?
  end

  test "message should be present" do
    @post.message = "   "
    assert_not @post.valid?
  end

  test "message should be at most 300 characters" do
    @post.message = "a" * 301
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end

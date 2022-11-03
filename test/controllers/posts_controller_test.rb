require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:river)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post user_posts_url(@user), params: {post: {message: @post.message, location_id: @post.location_id, user_id: @post.user_id}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete user_post_url(@user, @post)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    post = posts(:ants)
    assert_no_difference 'Post.count' do
      delete user_post_path(@user, post)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end

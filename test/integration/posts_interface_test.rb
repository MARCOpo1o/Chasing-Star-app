require "test_helper"

class PostsInterface < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @location = locations(:waltham)
    log_in_as(@user, password: 'password', remember_me: '1')
  end
end

class PostsInterfaceTest < PostsInterface

  test "should paginate posts" do
    get user_path(@user)
    assert_select 'ul.pagination'
  end

  test "should show errors but not create post on invalid submission" do
    assert_no_difference 'Post.count' do
      post user_posts_url(@user), params: { post: { message: "", location_id: @location.id, user_id: @user.id } }
    end
    assert_select 'div#error_explanation'
  end

  test "should create a post on valid submission" do
    message = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post user_posts_url(@user), params: { post: { message: message, location_id: @location.id, user_id: @user.id } }
    end
    assert_redirected_to @user
    follow_redirect!
    assert_match message, response.body
  end

  test "should have post delete links on own profile page" do
    get users_path(@user)
    assert_select 'a', text: 'delete'
  end

  test "should be able to delete own post" do
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete user_post_url(@user, first_post)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end

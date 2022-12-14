require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.user_name)
    assert_select 'h2', text: @user.user_name
    assert_match @user.posts.count.to_s, response.body

    assert_select 'ul.pagination'
  end
end
 
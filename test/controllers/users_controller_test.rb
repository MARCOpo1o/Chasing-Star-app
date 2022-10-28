require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def index
    @users = User.paginate(page: params[:page])
  end
end

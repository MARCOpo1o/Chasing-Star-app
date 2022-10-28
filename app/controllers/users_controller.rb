class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome Chasing Stars!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url, status: :see_other unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_url, status: :see_other unless current_user.admin?
  end
end

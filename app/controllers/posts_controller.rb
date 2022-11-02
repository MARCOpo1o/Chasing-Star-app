class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @user = current_user
    @post = Post.new
  end 

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to @current_user
    else
      render 'main_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:message, :location_id, :user_id)
  end

end

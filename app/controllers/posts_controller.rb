class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end 

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    @post.image.attach(params[:post][:image])

    if @post.save
      flash[:success] = "Post created!"
      redirect_to @current_user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :location_id, :user_id, :image)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @post.nil?
  end
end

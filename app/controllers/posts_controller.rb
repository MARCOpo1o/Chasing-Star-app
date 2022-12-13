class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
 
  def new
    @user = User.find(params[:user_id])
    @location = Location.find(params[:location_id])
    @post = Post.new
  end 

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], :per_page => 5) 
    @comment = Comment.new
    session.delete(:return_to)
    session[:return_to] = request.original_url 
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    @post.image.attach(params[:post][:image])
    
    if @post.save
      flash[:success] = "Post created!"
      redirect_to @post.location
    else
      puts @post.errors.full_messages
      flash[:danger] = @post.errors.full_messages
      redirect_to new_user_post_path(@user)
    end 

  end

  def destroy
    location = @post.location
    @post.destroy
    
    flash[:success] = "Post deleted"
    redirect_to location, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:message, :location_id, :user_id, :image, :rate)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @post.nil?
  end
end

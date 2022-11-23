class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy]
    before_action :correct_user,   only: :destroy
   
    def new
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    end
  
    def show
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:comment_id])
    end
  
    def create
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
      @comment = @user.comments.new(comment_params)
  
      if @comment.save
        flash[:success] = "Comment created!"
        redirect_to user_post_path(@user, @post)
      else
        render 'new', status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment.destroy
      flash[:success] = "Comment deleted"
      if request.referrer.nil?
        redirect_to root_url, status: :see_other
      else
        redirect_to request.referrer, status: :see_other
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:message, :post_id, :user_id)
    end
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @comment.nil?
    end
end

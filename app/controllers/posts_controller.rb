class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'main_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:messgae, :location_id)
  end
end

class MainPagesController < ApplicationController
  def home
  end

  def explore
    count =  Post.count
    posts = []
    30.times do
      random_offset = rand(count)
      posts.push(Post.offset(random_offset).first)
    end
    @rand_posts = posts
  end

end

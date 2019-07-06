class likeController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = current_user.like.new(post_id: post.id)
    like.save
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.like.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post.id)
  end

end

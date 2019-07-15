class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: post.id)
    like.save!
    render partial: "components/like/like", locals: {post: post}
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy!
    render partial: "components/like/like", locals: {post: post}
  end

end

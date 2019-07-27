class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: post.id)
    like.save!
    post.create_notification(current_user, "like")
    render partial: "components/like/like", locals: {post: post}
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy!
    render partial: "components/like/like", locals: {post: post}
  end
end

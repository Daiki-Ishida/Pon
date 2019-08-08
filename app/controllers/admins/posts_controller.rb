class Admins::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(12).order(created_at: :desc)
  end
end

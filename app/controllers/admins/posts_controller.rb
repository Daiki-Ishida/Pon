class Admins::PostsController < ApplicationController
  before_action :logged_in_admin

  def index
    @posts = Post.page(params[:page]).per(60).order(created_at: :desc)
  end
end

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(param[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
  end

  private

    def post_params
      params.require(:post).permit(:titel, :content, :image)
    end
end

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # current_user定義後要変更。
      @post.user_id = 1
      if @post.image
        save_image(@post, post_params)
      end
    else
      redirect_to ferrets_path
    end
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

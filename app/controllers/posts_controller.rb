class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # current_user定義後要変更。
    @post.user_id = 1
    if @post.save
      if @post.image
        save_image(@post, post_params)
        flash[:success] = "投稿しました！！"
        redirect_to post_path(@post)
      end
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id)
    @comment = Comment.new
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
      params.require(:post).permit(:title, :content, :image)
    end
end

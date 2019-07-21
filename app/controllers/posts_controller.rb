class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました！！"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def territory
    @posts = current_user.objects_within_territory("posts")
  end

  def following
    @posts = current_user.followings_posts
  end

  def search
    @posts = Post.search(params[:search])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
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

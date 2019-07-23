class PostsController < ApplicationController
  before_action :correct_post?, only: [:edit, :update, :destroy]
  beofre_aciton :logged_in_user, except: [:index, :show, :search]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
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
    @posts = current_user.followings_objects("posts")
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

    def correct_post?
      post = Post.find(params[:id])
      unless current_user == post.user
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

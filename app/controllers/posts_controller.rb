class PostsController < ApplicationController
  before_action :correct_post?, only: [:edit, :update, :destroy]
  before_action :logged_in_user, except: [:index, :show, :search]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:info] = "新しく投稿しました！"
      redirect_to post_path(@post)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def index
    @posts = Post.page(params[:page]).per(12).order(created_at: :desc)
  end

  def territory
    array = current_user.objects_within_territory("posts")
    @posts = Kaminari.paginate_array(array).page(params[:page]).per(12)
  end

  def following
    array = current_user.followings_objects("posts")
    @posts = Kaminari.paginate_array(array).page(params[:page]).per(12)
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).per(12).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:info] = "投稿内容を更新しました。"
      redirect_to post_path(post)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:warning] = "投稿を削除しました。"
    redirect_to my_posts_path
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

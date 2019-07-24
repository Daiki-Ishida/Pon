class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, only:[:edit, :update, :destroy, :territory, :followings]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.territory = 15
    if @user.save
      flash[:info] = "ご登録ありがとうございます！さっそくフェレットを登録してみましょう！"
      redirect_to ferrets_path
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def index
    @users = User.page(params[:page]).per(12).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def following_users
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def territory
    array = current_user.objects_within_territory("users")
    @users = Kaminari.paginate_array(array).page(params[:page]).per(12)
  end

  def followings
    @users = current_user.followings.page(params[:page]).per(12).order(created_at: :desc)
  end

  def search
    @users = User.search(params[:search]).page(params[:page]).per(12).order(created_at: :desc)
  end

  private

    def user_params
      params.require(:user).permit(:image,
                                   :kanji_lastname,
                                   :kanji_firstname,
                                   :kana_lastname,
                                   :kana_firstname,
                                   :name,
                                   :birth_date,
                                   :gender,
                                   :postal_code,
                                   :postal_address,
                                   :introduction,
                                   :latitude,
                                   :longitude)
    end

    def correct_user
      user = User.find(params[:id])
      flash[:warning] = "権限がありません。"
      redirect_to root_path unless user == current_user
    end
end

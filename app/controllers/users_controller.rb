class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.territory = 15
    if @user.save
      redirect_to ferrets_path
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user)
    else
      render 'edit'
    end
  end

  def destroy

  end

  def followings
    user = User.find(params[:id])
    @followings = user.followings
  end

  def followers
    user = User.find(params[:id])
    @followers = user.followers
  end

  def territory
    @users = current_user.objects_within_territory("users")
  end

  def followings
    @users = current_user.followings
  end

  def search
    @users = User.search(params[:search])
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
      redirect_to root_path unless user == current_user
    end
end

class UsersController < ApplicationController
  before_action :correct_user, only: [:rooms, :edit]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.image != "no_image.jpg"
        save_image(@user, user_params)
      end
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

  def rooms
    user = User.find(params[:id])
    @rooms = Room.where(guest_id: user.id).or(Room.where(owner_id: user.id))
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
                                   :introduction)
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_path unless user == current_user
    end
end

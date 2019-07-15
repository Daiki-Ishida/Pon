class UsersController < ApplicationController
  before_action :correct_user, only: [:rooms, :edit]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.territory = 15
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

  def territory
    @ferrets_within_territory = current_user.objects_within_territory("ferrets", current_user.other_users)
  end

  def update_territory
    user = User.find(params[:id])
    if user.update(territory_param)
      redirect_to territory_user_path(user)
    else
      flash[:notice] = "ERROR"
      render 'territory'
    end
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

    def territory_param
      params.require(:user).permit(:territory)
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_path unless user == current_user
    end
end

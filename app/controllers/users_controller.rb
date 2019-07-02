class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
  end

  def index
    @users = User.all
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def user_params
      params.require(:user).permit(:kanji_lastname,
                                   :kanji_firstname,
                                   :kana_lastname,
                                   :kana_firstname,
                                   :name,
                                   :postal_code,
                                   :postal_address,
                                   :image)
    end
end

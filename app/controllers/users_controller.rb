class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.image
        save_user_image
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

  end

  def edit

  end

  def update

  end

  def destroy

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
                                   )
    end

    def save_user_image
      image = user_params[:image]
      @user.update_attribute(:image, "#{@user.id}.jpg")
      File.binwrite("public/user_images/#{@user.image}", image.read)
    end
end

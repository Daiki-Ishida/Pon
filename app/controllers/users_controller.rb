class UsersController < ApplicationController
  before_action :already_logged_in, only:[:new, :create]
  before_action :logged_in_user, only:[:edit, :update, :destroy, :territory, :followings]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.geocode
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "ご入力頂いたメールアドレスにメールを送付しました。
                      本登録手続きをお願いいたします！"
      redirect_to ferrets_path
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.geocode
    if @user.update(user_params)
      redirect_to user_path(@user)
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

  def index
    @users = User.page(params[:page]).per(12).order(created_at: :desc)
    @sort = ""
  end

  def territory
    array = current_user.objects_within_territory("users")
    @users = Kaminari.paginate_array(array).page(params[:page]).per(12)
    @sort = "territory"
    render 'index'
  end

  def followings
    @users = current_user.followings.page(params[:page]).per(12).order(created_at: :desc)
    @sort = "followings"
    render 'index'
  end

  def search
    @users = User.search(params[:search]).page(params[:page]).per(12).order(created_at: :desc)
    render 'index'
  end

  def sort
    status = params[:status]
    gender = params[:gender]
    record = params[:record]
    sort = params[:sort]
    @users = User.sorted_by(sort, current_user)
    # もういっそ全部配列にしてしまうおう
    @users = @users.to_a unless @users.kind_of?(Array)
    @users = @users.select{|user| user[:status] == status.to_i} if status.present?
    @users = @users.select{|user| user[:gender] == gender.to_i} if gender.present?
    @users = @users.select{|user| user.contracts_as_sitter.size.to_i >= record.to_i} if record.present?
    array = @users.reverse
    @users = Kaminari.paginate_array(array).page(params[:page]).per(12)
    @sort = sort
    render 'index'
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
                                   :longitude,
                                   :email,
                                   :password,
                                   :password_confirmation
                                 )
    end

    def correct_user
      user = User.find(params[:id])
      unless user == current_user
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

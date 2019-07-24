class FerretsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show, :search]
  before_action :correct_owner?, only: [:edit, :update, :destroy]

  def index
    @ferrets = Ferret.page(params[:page]).per(12).order(created_at: :desc)
  end

  def new
    @ferret = current_user.ferrets.build
  end

  def create
    @ferret = Ferret.new(ferret_params)
    @ferret.user_id = current_user.id
    if @ferret.save
      flash[:info] = "新しくフェレットを登録しました！"
      redirect_to ferret_path(ferret)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def show
    @ferret = Ferret.find(params[:id])
    # 自身を除いた兄弟を得る。
    @siblings = Ferret.where(user_id: @ferret.user_id).where.not(id: @ferret.id)
  end

  def edit
    @ferret = Ferret.find(params[:id])
  end

  def update
    ferret = Ferret.find(params[:id])
    if ferret.update(ferret_params)
      flash[:info] = "フェレットの登録内容を更新しました。"
      redirect_to ferret_path(ferret)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'edit'
    end
  end

  def destroy
    ferret = Ferret.find(params[:id])
    ferret.destroy
    flash[:warning] = "フェレットの登録を削除しました。"
    redirect_to ferrets_path
  end

  def territory
    array = current_user.objects_within_territory("ferrets")
    @ferrets = Kaminari.paginate_array(array).page(params[:page]).per(12)
  end

  def followings
    array = current_user.followings_objects("ferrets")
    @ferrets = Kaminari.paginate_array(array).page(params[:page]).per(12)
  end

  def search
    @ferrets = Ferret.search(params[:search]).page(params[:page]).per(12).order(created_at: :desc)
  end

  private

    def ferret_params
      params.require(:ferret).permit(:image,
                                     :name,
                                     :gender,
                                     :character,
                                     :introduction,
                                     :birth_date)
    end

    def correct_owner?
      ferret = Ferret.find(params[:id])
      unless current_user == ferret.user
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

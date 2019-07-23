class FerretsController < ApplicationController
  before_aciton :logged_in_user, except: [:index, :show, :search]
  before_action :correct_owner?, only: [:edit, :update, :destroy]

  def index
    @ferrets = Ferret.all
  end

  def new
    @ferret = current_user.ferrets.build
  end

  def create
    @ferret = Ferret.new(ferret_params)
    @ferret.user_id = current_user.id
    if @ferret.save
      redirect_to ferrets_path
    else
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
      flash[:notice] = "更新完了"
      redirect_to ferret_path(ferret)
    else
      render 'edit'
    end
  end

  def destroy
    ferret = Ferret.find(params[:id])
    ferret.destroy
    redirect_to ferrets_path
  end

  def territory
    @ferrets = current_user.objects_within_territory("ferrets")
  end

  def followings
    @ferrets = current_user.followings_objects("ferrets")
  end

  def search
    @ferrets = Ferret.search(params[:search])
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
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

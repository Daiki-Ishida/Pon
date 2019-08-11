class FerretsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show, :search, :sort]
  before_action :activated_account, except: [:index, :show, :search, :sort]
  before_action :correct_owner?, only: [:edit, :update, :destroy]

  def new
    @ferret = current_user.ferrets.build
  end

  def create
    ferret = Ferret.new(ferret_params)
    ferret.user_id = current_user.id
    if ferret.save
      flash[:info] = "新しくフェレットを登録しました！"
      redirect_to ferret_path(ferret)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def show
    @ferret = Ferret.find(params[:id])
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

  def index
    @ferrets = Ferret.page(params[:page]).per(12).order(created_at: :desc)
    @sort = ""
  end

  def territory
    array = current_user.objects_within_territory("ferrets").reverse
    @ferrets = Kaminari.paginate_array(array).page(params[:page]).per(12)
    @sort = "territory"
    render 'index'
  end

  def followings
    array = current_user.followings_objects("ferrets").reverse
    @ferrets = Kaminari.paginate_array(array).page(params[:page]).per(12)
    @sort = "followings"
    render 'index'
  end

  def search
    @ferrets = Ferret.search(params[:search]).page(params[:page]).per(12).order(created_at: :desc)
    @sort = ""
    render 'index'
  end

  def sort
    status = params[:status]
    gender = params[:gender]
    range = params[:range]
    today = Date.today.strftime('%Y%m%d').to_i
    sort = params[:sort]
    @ferrets = Ferret.sorted_by(sort, current_user)
    @ferrets = @ferrets.to_a unless @ferrets.kind_of?(Array)
    @ferrets = @ferrets.select{|ferret| ferret.user[:status] == status.to_i} if status.present?
    @ferrets = @ferrets.select{|ferret| ferret.user[:gender] == gender.to_i} if gender.present?
    if range.present?
      case range
      when "1才未満"
        @ferrets = @ferrets.select{|ferret| (today - ferret.birth_date.strftime('%Y%m%d').to_i) / 10000 < 1}
      when "1才〜３才"
        @ferrets = @ferrets.select{|ferret| 1 <= (today - ferret.birth_date.strftime('%Y%m%d').to_i) && (today - ferret.birth_date.strftime('%Y%m%d').to_i) / 10000 < 4}
      when "４才以上"
        @ferrets = @ferrets.select{|ferret| (today - ferret.birth_date.strftime('%Y%m%d').to_i) / 10000 >= 4}
      end
    end
    array = @ferrets.reverse
    @ferrets = Kaminari.paginate_array(array).page(params[:page]).per(12)
    @sort = sort
    render 'index'
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

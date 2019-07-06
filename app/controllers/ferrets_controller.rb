class FerretsController < ApplicationController
  def index
    @ferrets = Ferret.all
  end

  def new
    @ferret = Ferret.new
  end

  def create
    @ferret = Ferret.new(ferret_params)
    @ferret.user_id = current_user.id
    if @ferret.save
      if @ferret.image
        save_image(@ferret, ferret_params)
      end
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

  private

    def ferret_params
      params.require(:ferret).permit(:image,
                                     :name,
                                     :gender,
                                     :character,
                                     :introduction,
                                     :birth_date)
    end

    # フェレットから親を先頭に家族の画像、名前を取得。
    # 回りくどい書き方のようにも見える。余裕があれば、他の方法がないか検討。
    # def family(ferret)
    #   parent = ferret.user
    #   siblings = parent.ferrets
    #   fer_arr = siblings.each_with_object([]) do |s, array|
    #     array << {image: s.image, name: s.name}
    #   end
    #   par_arr = [{image: parent.image, name: parent.name}]
    #   family_members = fer_arr.unshift(par_arr).flatten
    #   return family_members
    # end
end

class MyController < ApplicationController
  before_action :logged_in_user

  def page

  end

  def territory
    @ferrets = current_user.objects_within_territory("ferrets")
  end

  def update_territory
    if current_user.update(territory_param)
      flash[:info] = "エリアを変更しました！"
      redirect_to my_territory_path
    else
      flash[:danger] = "入力内容に誤りがあります。"
      render 'territory'
    end
  end

  def rooms
    @rooms = Room.where(guest_id: current_user.id)
                 .or(Room.where(owner_id: current_user.id))
                 .page(params[:page])
                 .order(created_at: :desc)
  end

  def settings

  end

  def ferrets
    @ferrets = current_user.ferrets.page(params[:page]).order(created_at: :desc)
  end

  def posts
    @posts = current_user.posts.page(params[:page]).per(12).order(created_at: :desc)
  end

  def notifications
    @notifications = current_user.passive_notifications.page(params[:page]).order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  private
    def territory_param
      params.require(:user).permit(:territory)
    end
end

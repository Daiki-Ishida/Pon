class MyController < ApplicationController
  def territory
    @ferrets = current_user.objects_within_territory("ferrets")
  end

  def update_territory
    if current_user.update(territory_param)
      redirect_to my_territory_path
    else
      flash[:notice] = "ERROR"
      render 'territory'
    end
  end

  def rooms
    @rooms = Room.where(guest_id: current_user.id).or(Room.where(owner_id: current_user.id))
  end

  def settings

  end

  def ferrets
    @ferrets = current_user.ferrets
  end

  def notifications
    @notifications = current_user.passive_notifications
  end

  private
    def territory_param
      params.require(:my).permit(:territory)
    end
end
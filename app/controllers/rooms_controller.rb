class RoomsController < ApplicationController
  def create
    if room_exist?
      redirect_to room_path(room)
    else
      room = Room.new(room_param)
      room.owner_id = current_user.id
      if room.save
        redirect_to room_path(room)
      else
        flash[:warning] = "ERROR!"
        redirect_to root_path
      end
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private
    def room_param
      params.require().permit(:guest_id)
    end

    # ownerとguestが逆のroomが存在するか確認。
    def room_exist?
      room = Room.find_by(guest_id: current_user.id, owner_id: room_param)
    end
end

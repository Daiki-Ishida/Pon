class RoomsController < ApplicationController
  before_action :room_exist?, only: [:create]
  before_action :correct_room?, only: [:show]
  before_action :logged_in_user

  def create
    room = Room.new(room_param)
    room.owner_id = current_user.id
    if room.save
      redirect_to room_path(room)
    else
      flash[:warning] = "ERROR!"
      redirect_to root_path
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private
    def room_param
      params.permit(:guest_id)
    end

    # ownerとguestが逆の場合も含めてroomが存在するか確認。
    def room_exist?
      room = Room.find_by(guest_id: current_user.id, owner_id: params[:guest_id]) || Room.find_by(guest_id: params[:guest_id], owner_id: current_user.id)
      if room
        redirect_to room_path(room)
      end
    end

    def correct_room?
      room = Room.find(params[:id])
      unless current_user == room.owner || current_user == room.guest
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

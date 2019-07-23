class MessagesController < ApplicationController
  before_action :correct_room?
  before_aciton :logged_in_user

  def create
    room = Room.find(params[:room_id])
    message = room.messages.build(message_param)
    message.sender_id = current_user.id
    if message.save
      message.create_notification(current_user, room)
      redirect_to room_path(room)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      redirect_to room_path(message.room)
    end
  end

  private
    def message_param
      params.require(:message).permit(:content)
    end

    def correct_room?
      room = Room.find(params[:id])
      unless current_user == room.owner || current_user == room.guest
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

class MessagesController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    message = room.messages.build(message_param)
    message.sender_id = current_user.id
    if message.save
      # 非同期にする予定
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      redirect_to room_path(message.room)
    end
  end

  private
    def message_param
      params.require(:message).permit(:content, :room_id)
    end
end

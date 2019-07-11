class MessagesController < ApplicationController
  def create
    message = Message.new(message_param)
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
      params.require().permit(:room_id)
    end
end

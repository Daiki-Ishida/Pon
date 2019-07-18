class RequestsController < ApplicationController

  def new
    @request = Request.new
    @user = User.find(params[:user_id])
  end

  def create
    request = Request.new(request_params)
    request.owner_id = current_user.id
    if request.save
      flash[:success] = "依頼を提出しました。"
      room = find_room(request)
      create_notice(request, room)
      redirect_to room_path(room)
    else
      flash[:error] = "入力に誤りがあります。"
      redirect_to root_path
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def index

  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    request = Request.find(params[:id])
    if request.update(request_params)
      flash[:success] = "依頼を更新しました。"
      room = find_room(request)
      update_notice(request, room)
      redirect_to request_path(request)
    else
      flash[:error] = "入力に誤りがあります。"
      render 'edit'
    end
  end

  def destroy

  end

  private
    def request_params
      params.require(:request).permit(:sitter_id, :start_at, :end_at, :fee, :memo)
    end

    def find_room(request)
      room = Room.find_by(owner_id: current_user, guest_id: request.sitter_id) || Room.find_by(owner_id: request.sitter_id, guest_id: currrent_user.id)
    end

    def create_notice(request, room)
      message = Message.create!(
        sender_id: current_user.id,
        room_id: room.id,
        content: "#{request.owner.name}さんが正式依頼を出しました!
                  #{request.sitter.name}さんは次のリンクからご確認をお願いします！
                  http://localhost:3000/requests/#{request.id}"
      )
    end

    def update_notice(request, room)
      message = Message.create!(
        sender_id: current_user.id,
        room_id: room.id,
        content: "#{request.owner.name}さんが依頼を編集しました!
                  #{request.sitter.name}さんは次のリンクからご確認をお願いします！
                  http://localhost:3000/requests/#{request.id}"
      )
    end
end

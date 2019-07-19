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
      message = request.send_notice(current_user, "create", request_url(request))
      redirect_to room_path(message.room)
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
      message = request.send_notice(current_user, "update", request_url(request))
      redirect_to room_path(message.room)
    else
      flash[:error] = "入力に誤りがあります。"
      render 'edit'
    end
  end

  def destroy
    request = Request.find(params[:id])
    if request.destroy
      flash[:success] = "依頼を取り下げました"
      message = request.send_notice(current_user, "withdraw", nil)
      redirect_to room_path(message.room)
    else
      flash[:error] = "ERROR!"
      redirect_to request_path(request)
    end
  end

  private
    def request_params
      params.require(:request).permit(:sitter_id, :start_at, :end_at, :fee, :memo)
    end
end

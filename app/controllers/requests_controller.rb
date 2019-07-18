class RequestsController < ApplicationController

  def new
    @request = Request.new
    @user = User.find(params[:user_id])
  end

  def create
    request = current_user.requests.build(request_params)
    if request.save
      flash[:success] = "依頼を提出しました。"
      redirect_to root_path
    else
      flash[:error] = "入力に誤りがあります。"
      redirect_to root_path
    end
  end

  def index

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def request_params
      params.require(:request).permit(:start_at, :end_at, :memo, :sitter_id)
    end
end

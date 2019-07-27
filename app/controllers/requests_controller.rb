class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :has_ferrets?, except: [:show]
  before_action :has_request?, only: [:new, :create]
  before_action :concerned_person?, except: [:new, :create]

  def new
    @request = Request.new
    @user = User.find(params[:user_id])
  end

  def create
    request = Request.new(request_params)
    request.owner_id = current_user.id
    if request.save
      flash[:info] = "依頼を提出しました！"
      message = request.send_notice(current_user, "create", request_url(request))
      message.create_notification(current_user, message.room)
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力に誤りがあります。"
      redirect_to root_path
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    request = Request.find(params[:id])
    if request.update(request_params)
      flash[:info] = "依頼を更新しました。"
      message = request.send_notice(current_user, "update", request_url(request))
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力に誤りがあります。"
      render 'edit'
    end
  end

  def destroy
    request = Request.find(params[:id])
    if request.destroy
      flash[:info] = "依頼を取り下げました"
      message = request.send_notice(current_user, "withdraw", nil)
      redirect_to room_path(message.room)
    else
      flash[:warning] = "ERROR!"
      redirect_to request_path(request)
    end
  end

  private
    def request_params
      params.require(:request).permit(:sitter_id, :start_at, :end_at, :fee, :memo)
    end

    def has_ferrets?
      if current_user.ferrets.blank?
        flash[:warning] = "フェレットが登録されていません。まずはフェレットのご登録からお願いします。"
        redirect_to new_ferret_path
      end
    end

    def has_request?
      request = Request.find_by(owner_id: current_user.id)
      if request.present?
        flash[:warning] = "正式依頼は同時に１つしか提示できません。正式依頼を出し直す場合は、お手数ですが、一度依頼を取り下げてください。"
        redirect_to edit_request_path(request)
      end
    end

    def concerned_person?
      request = Request.find(params[:id])
      unless current_user == request.owner || current_user == request.sitter
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

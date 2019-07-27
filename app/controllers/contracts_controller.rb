class ContractsController < ApplicationController
  before_action :logged_in_user
  before_action :authorized_user?, only: [:create]
  before_action :concerned_user?, only: [:show]


  def create
    request = Request.find(params[:request_id])
    contract = Contract.new(
      owner_id: request.owner_id,
      sitter_id: request.sitter_id,
      fee: request.fee,
      start_at: request.start_at,
      end_at: request.start_at,
      memo: request.memo
    )
    if contract.save
      flash[:info] = "リクエストを承認しました！"
      message = request.send_notice(request.sitter, "approved", contract_url(contract))
      message.create_notification(current_user, message.room)
      request.destroy!
      contract.owner.status = nil
      redirect_to room_path(message.room)
    else
      flash[:danger] = "エラーが発生しました。お手数ですが、運営までお問い合わせください。"
      redirect_to edit_request_path(request)
    end
  end

  def show
    @contract = Contract.find(params[:id])
  end

  private
    def concerned_user?
      contract = Contract.find(params[:id])
      unless current_user == contract.owner || current_user == contract.sitter
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end

    def authorized_user?
      request = Request.find(params[:request_id])
      unless current_user == request.sitter
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

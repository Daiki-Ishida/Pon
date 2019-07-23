class ContractsController < ApplicationController
  before_action :logged_in_user
  before_action :concerned_user?

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
      message = request.send_notice(request.sitter, "approved", contract_url(contract))
      request.destroy!
      redirect_to room_path(message.room)
    else
      flash[:warning] = "ERROR!"
      redirect_to edit_request_path(request)
    end
  end

  def show
    @contract = Contract.find(params[:id])
  end

  private
    def concerned_user?
      contract = Contract.find(params[:id])
      unless current_user == contract.owner || contact.sitter
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

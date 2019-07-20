class ContractsController < ApplicationController


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
end

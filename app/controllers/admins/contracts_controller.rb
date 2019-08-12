class Admins::ContractsController < ApplicationController
  def index
    @contracts = Contract.page(params[:page]).order(created_at: :desc)
  end

  def show
    @contract = Contract.find(params[:id])
  end
end

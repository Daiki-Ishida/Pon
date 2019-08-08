class Admins::ContractsController < ApplicationController
  def index
    @contracts = Contract.page(params[:page]).order(created_at: :desc)
  end
end

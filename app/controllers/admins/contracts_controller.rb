class Admins::ContractsController < ApplicationController
  before_action :logged_in_admin

  def index
    @contracts = Contract.page(params[:page]).per(30).order(created_at: :desc)
  end

  def show
    @contract = Contract.find(params[:id])
  end
end

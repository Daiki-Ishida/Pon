class ReportsController < ApplicationController
  def new
    contract = Contract.find(params[:contract_id])
    @report = contract.reports.build
  end

  def create

  end

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def report_params
      
    end
end

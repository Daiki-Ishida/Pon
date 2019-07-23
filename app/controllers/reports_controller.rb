class ReportsController < ApplicationController
  before_action :correct_issuer?, except: [:index, :show]
  before_action :logged_in_user

  def new
    contract = Contract.find(params[:contract_id])
    @report = contract.reports.build
  end

  def create
    contract = Contract.find(params[:contract_id])
    report = contract.reports.build(report_params)
    if report.save
      flash[:info] = "レポートを提出しました！"
      message = report.send_notice(current_user, "create", contract_report_url(report.contract, report))
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def index
    contract = Contract.find(params[:contract_id])
    @reports = contract.reports
  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private
    def report_params
      params.require(:report).permit(:date, :content, :image)
    end

    def correct_issuer?
      contract = Contract.find(params[:contract_id])
      unless current_user == contract.sitter
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

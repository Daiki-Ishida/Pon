class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action ->{
    contract_concerned_user(params[:contract_id])
    }
  before_action :sitter_in_contract_only, except: [:index, :show]

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
      message.create_notification(current_user, message.room)
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
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:info] = "レポートを修正しました！"
      message = report.send_notice(current_user, "update", contract_report_url(@report.contract, @report))
      message.create_notification(current_user, message.room)
      redirect_to room_path(message.room)
    else
      flash[:danger] = "入力内容に誤りがあります。"
      render 'edit'
    end
  end

  def destroy

  end

  private
    def report_params
      params.require(:report).permit(:date, :content, :image)
    end
end

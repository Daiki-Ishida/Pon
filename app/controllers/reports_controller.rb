class ReportsController < ApplicationController
  def new
    contract = Contract.find(params[:contract_id])
    @report = contract.reports.build
  end

  def create
    contract = Contract.find(params[:contract_id])
    report = contract.reports.build(report_params)
    if report.save
      flash[:seccess] = "レポートを提出しました！"
      message = report.send_notice(current_user, "create", contract_report_url(report.contract, report))
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  def index

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
      params.require(:report).permit(:date, :content)
    end
end

class ReviewsController < ApplicationController
  before_action :correct_reviewer?
  before_action :logged_in_user

  def new
    contract = Contract.find(params[:contract_id])
    @review = contract.build_review
  end

  def create
    contract = Contract.find(params[:contract_id])
    review = contract.build_review(review_params)
    if review.save
      flash[:info] = "レビューしました！"
      message = review.send_notice(current_user, "create", nil)
      message.create_notification(current_user, message.room)
      redirect_to room_path(message.room)
    else
      flash[:warning] = "入力内容に誤りがあります。"
      render 'new'
    end
  end

  private
    def review_params
      params.require(:review).permit(:rate, :comment)
    end

    def correct_reviewer?
      contract = Contract.find(params[:contract_id])
      unless current_user == contract.owner
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

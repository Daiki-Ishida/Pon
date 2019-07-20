class ReviewsController < ApplicationController
  before_action :is_correct_reviewer?

  def new
    contract = Contract.find(params[:contract_id])
    @review = contract.build_review
  end

  def create
    contract = Contract.find(params[:contract_id])
    review = contract.build_review(review_params)
    if review.save
      flash[:seccess] = "レビューしました！"
      message = review.send_notice(current_user, "create", nil)
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

    def is_correct_reviewer?
      contract = Contract.find(params[:contract_id])
      unless current_user == contract.owner
        flash[:warning] = "権限がありません。"
        redirect_to root_path
      end
    end
end

class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :activated_account
  before_action ->{
    contract_concerned_user(params[:contract_id])
    }
  before_action :owner_in_contract_only

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
end

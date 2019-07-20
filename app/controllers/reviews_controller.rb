class ReviewsController < ApplicationController
  def new
    contract = Contract.find(params[:contract_id])
    @review = contract.build_review
  end

  def create

  end

end

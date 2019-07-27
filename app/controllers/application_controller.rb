class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join("frontend")
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        flash[:warning] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def contract_concerned_user(id)
      contract = Contract.find(id)
      unless current_user == contract.owner || current_user == contract.sitter
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end

    def owner_in_contract_only
      contract = Contract.find(params[:contract_id])
      unless current_user == contract.owner
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end

    def sitter_in_contract_only
      contract = Contract.find(params[:contract_id])
      unless current_user == contract.sitter
        flash[:danger] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join("frontend")
  include SessionsHelper
  include Admins::SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        flash[:warning] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def already_logged_in
      if logged_in?
        flash[:warning] = "すでにログインしています。"
        redirect_to my_page_url
      end
    end

    def activated_account
      if !current_user.activated?
        flash[:warning] = "アカウントが有効ではありません。"
        redirect_to root_path
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

    def logged_in_admin
      unless logged_in_as_admin?
        flash[:warning] = "権限がありません。"
        redirect_to ferrets_path
      end
    end
end

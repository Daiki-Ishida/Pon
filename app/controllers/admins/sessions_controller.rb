class Admins::SessionsController < ApplicationController
  before_action :logged_in_admin, only:[:destroy]

  def create
    admin = Admin.find_by(email: params[:email].downcase)
    if admin && admin.authenticate(params[:password])
      admin_log_in(admin)
      redirect_to admins_top_path
    else
      flash[:warning] = "入力内容に誤りがあります。"
      redirect_to admins_login_path
    end
  end

  def destroy
    session.delete(:admin_id)
    flash[:danger] = "ログアウトしました。"
    redirect_to root_path
  end
end

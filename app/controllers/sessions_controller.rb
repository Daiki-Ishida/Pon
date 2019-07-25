class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:info] = "ログインしました！"
      redirect_to my_page_path
    else
      flash[:danger] = "メールアドレスまたはパスワードが誤っています。"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil
    flash[:danger] = "ログアウトしました。"
    redirect_to root_path
  end

end

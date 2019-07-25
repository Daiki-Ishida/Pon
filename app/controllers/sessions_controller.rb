class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in(user)
        flash[:info] = "ログインしました！"
        redirect_to my_page_path
      else
        flash[:warning] = "アカウントが有効ではありません。メールをご確認頂き、本登録をお願いいたします。"
        redirect_to root_path
      end
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

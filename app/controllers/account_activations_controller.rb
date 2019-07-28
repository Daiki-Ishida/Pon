class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(params[:id])
      user.activate
      log_in user
      flash[:success] = "ご登録ありがとうございます!アカウントが有効になりました！"
      redirect_to my_page_path
    else
      flash[:danger] = "リンクが有効ではありません。"
      redirect_to root_url
    end
  end
end

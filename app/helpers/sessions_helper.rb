module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  # current_userが存在していれば（ユーザーがログインしていれば）ture
  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:user_id]
      current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 対象のユーザーが現在のユーザーかどうかの確認。
  def current_user?(user)
    user == current_user
  end
end

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
end

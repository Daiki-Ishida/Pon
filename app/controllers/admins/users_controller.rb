class Admins::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(120).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
end

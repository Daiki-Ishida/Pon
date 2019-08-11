class Admins::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(120).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.inactivate
      flash[:info] = "#{@user.name}（ID: #{@user.id}）を強制退会させました。"
      redirect_to admins_users_path
    else
      flash[:warning] = "エラーが発生しました。"
      render 'edit'
    end
  end
end

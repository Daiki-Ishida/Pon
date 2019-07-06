class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user
      log_in(user)
      redirect_to ferrets_path
    else
      render 'new'
    end
  end

  def destroy

  end
end

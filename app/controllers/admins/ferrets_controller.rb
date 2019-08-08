class Admins::FerretsController < ApplicationController
  def index
    @ferrets = Ferret.page(params[:page]).per(120).order(created_at: :desc)
  end
end

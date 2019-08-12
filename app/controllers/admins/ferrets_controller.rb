class Admins::FerretsController < ApplicationController
  def index
    @ferrets = Ferret.page(params[:page]).per(120).order(created_at: :desc)
  end

  def show
    @ferret = Ferret.find(params[:id])
  end

  def destroy
    ferret = Ferret.find(params[:id])
    if ferret.destroy
      flash[:warning] = "フェレットを削除しました。"
      # 管理者の強制削除なので、不適切な登録である旨をユーザーに通知するメーラーを設定する予定。
    else
      flash[:warning] = "エラーが発生しました。"
      redirect_to admins_top_path
    end
  end
end

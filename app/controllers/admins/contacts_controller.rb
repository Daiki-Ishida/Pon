class Admins::ContactsController < ApplicationController
  before_action :logged_in_admin

  def index
    @contacts = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:info] = "問い合わせに返答しました"
      redirect_to admins_top_path
    else
      render 'edit'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:reply, :resolved)
    end
end

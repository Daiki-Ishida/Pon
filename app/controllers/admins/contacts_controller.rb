class Admins::ContactsController < ApplicationController
  before_action :logged_in_admin

  def index
    @contacts = Contact.page(params[:page]).per(60).order(created_at: :desc)
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      ContactMailer.reply(@contact).deliver_now unless @contact.reply.empty?
      flash[:info] = "問い合わせに返答しました"
      redirect_to admins_contacts_path
    else
      render 'edit'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:reply, :resolved)
    end
end

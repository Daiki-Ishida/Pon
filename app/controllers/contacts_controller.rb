class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:info] = "お問い合わせを受け付けました。"
      redirect_to ferrets_path
    else
      render 'new'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:email, :content, :subject)
    end
end

class ContactMailer < ApplicationMailer
  def contact(contact)
    @contact = contact
    mail to: @contact.email, subject: "PON：お問い合わせありがとうございます"
  end

  def reply(contact)
    @contact = contact
    mail to: @contact.email, subject: "PON：お問い合わせに対するご回答"
  end
end

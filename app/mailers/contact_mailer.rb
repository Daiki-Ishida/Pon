class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact.subject
  #
  def contact(contact)
    @contact = contact
    mail to: @contact.email, subject: "PON：お問い合わせありがとうございます"
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contact
  def contact
    contact = Contact.first
    ContactMailer.contact(contact)
  end

  def reply
    contact = Contact.first
    ContactMailer.reply(contact)
  end

end

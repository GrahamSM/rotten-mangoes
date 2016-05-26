class UserMailer < ApplicationMailer

  default from: 'graham.sm94@gmail.com'

  def delete_email(user)
    mail(to: user.email, subject: 'Account Deletion')
  end
end

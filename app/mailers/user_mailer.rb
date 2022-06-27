class UserMailer < ApplicationMailer
  default from: 'admin@facelord.com'

  def welcome_email(resource)
    @user = resource
    mail(to: @user.email, subject: 'welcome to facelord')
  end
end

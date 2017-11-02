class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = "http://docs-for-us.herokuapp.com/login"
    mail(to: @user.email, subject: 'Welcome to DocsForUs')
  end

end

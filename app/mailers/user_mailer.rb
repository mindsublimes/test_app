class UserMailer < ApplicationMailer

  def welcome_email
    @email = params[:email]
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end


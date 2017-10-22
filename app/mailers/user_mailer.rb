class UserMailer < ApplicationMailer
    
    default from: 'enviosyarq@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'enviosyarq@gmail.com', subject: 'Welcome to My Awesome Site')
  end
    
end

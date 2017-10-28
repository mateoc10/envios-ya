class UserMailer < ApplicationMailer
    
    default from: 'enviosyarq@gmail.com'
 
  def welcome_email(receiverEmail, senderId)
    @email = receiverEmail
    @senderId = senderId
    @url  = 'http://example.com/login'
    mail(to: receiverEmail, subject: 'You have been invited to EnviosYarq')
  end
    
end

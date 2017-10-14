class ApplicationMailer < ActionMailer::Base
  default from: 'mateoc10@gmail.com'
  layout 'mailer'
  
  def invitation_email(user)
    @user = user
    mail(to: @user.email, subject: 'one estrit of ceparation')
  end
end

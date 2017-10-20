# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = {
#   address:              'smtp.gmail.com',
#   port:                 587,
#   domain:               'gmail.com',
#   user_name:            'erreperez2',
#   password:             'erreperez11',
#   authentication:       'plain',
#   enable_starttls_auto: true  
  
# }

# ActionMailer::Base.smtp_settings = {
#   :user_name => 'erreperez2@gmail.com',
#   :password => 'erreperez11',
#   :domain => 'gmail.com',
#   :address => 'smtp.sendgrid.net',
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true
#}
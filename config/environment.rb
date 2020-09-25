# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
      :tls => true,
      :address => "smtp.gmail.com",
      :port => 465,
      :domain => "gmail.com",
      :authentication => :login,
      :user_name => "twitter.prueba69@gmail.com",
      :password => "DanielValencia.OmarMejia"
    }
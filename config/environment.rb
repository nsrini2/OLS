# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LeaveSystem::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => 'smtp.gmail.com',
:port => 587,
:authentication => :plain,
:user_name => 'agentstream.tnss@gmail.com',
:password => 'abcd-9999',
:openssl_verify_mode => 'none'
}


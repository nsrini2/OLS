class Notifications < ActionMailer::Base
helper EmailHelper

default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.forgot_password.subject
  #
  def forgot_password(to,login,pass,emp, sent_at=Time.now)
    @sub="Your new password is....."
    @greeting = "Hi #{emp.first_name} "
    @recipients=to
    @from='agentstream.tnss@gmail.com'
    @sent_on=sent_at
    @password=pass
    mail(:to => @recipients, :subject => @sub, :password => pass)

  end

  def welcome(user)
    @login=user.login
    @name=user.employee.first_name.capitalize
    @greeting = "Dear #{@name}"
    @password_set_link=url_for(:controller => 'authentication', :action => 'set_password', :id => user.id)
    mail(:to => user.email, :subject => "Welcome to RapidThink")
  end
end

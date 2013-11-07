module AuthenticatedSystem
 
  protected

  def logged_in?
     current_user != :false
  end

  def current_user
     @current_user ||= (login_from_session || :false)
     employee=@current_user.employee
     @current_user
  end

 
  def current_user=(user)
    session[:user]=user.nil? ? nil : user.id

  end

  def store_location
     session[:return_to]=request.url
  end

  def redirect_back_or_default(default)
     session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
     session[:return_to]=nil
  end


  def login_from_session
      session[:user] && User.find_by_id(session[:user])
  end

end
     



        

      





require 'authenticated_system'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cache_remove


  def login_required
       return true if session[:user]
       flash[:errors]="Please login to continue"
       session[:return_to]=request.url
       redirect_to :controller => "authentication", :action => "login"
       return false
  end


  def current_user
      session[:user]
  end

  def current_emp
      session[:user].employee
  end


  def set_cache_remove
      response.headers["Cache-Control"]="no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"]="no-cache"
      response.headers["Expires"]="Fri, 01 Jan 1990 00:00:00 GMT"
  end
  

end

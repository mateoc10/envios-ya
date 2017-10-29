class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include DriverSessionsHelper
 
  def require_login(role)
    unless logged_in? && role == "user" || logged_in_driver? && role == "driver"
      flash[:error] = "Debe loguearse para utilizar esta funcionalidad"
      redirect_to root_path
    end
  end
  
  def hello
    
  end
end

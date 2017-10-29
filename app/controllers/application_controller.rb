class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include DriverSessionsHelper
  
  before_action :require_login
 
  private
 
  def require_login
    unless logged_in? || logged_in_driver?
      flash[:error] = "Debe loguearse para utilizar esta funcionalidad"
      redirect_to '#'
    end
  end
  
  def hello
    
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # before_action :require_login
 
  # private
 
  # def require_login
  #   unless logged_in?
  #     flash[:error] = "Debe estar logeado para ejecutar esta función"
  #     redirect_to '#'
  #   end
  # end
  
  def hello
    
  end
end

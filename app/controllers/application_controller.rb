class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include DriverSessionsHelper
  
  # before_action :require_login
 
  # private
 
  # def require_login
  #   unless logged_in?
<<<<<<< HEAD
  #     flash[:error] = "Debe estar logeado para ejecutar esta función"
=======
  #     flash[:error] = "Debe loguearse para utilizar esta funcionalidad"
>>>>>>> 9fcfec33850751d3cfb2f24b7c27bc9456b068a8
  #     redirect_to '#'
  #   end
  # end
  
  def hello
    
  end
end

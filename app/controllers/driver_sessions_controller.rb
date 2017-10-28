class DriverSessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create] 
  def new
  end
  
  def create
    driver = Driver.find_by(email: params[:session][:email].downcase)
    if driver && driver.authenticate(params[:session][:password])
      log_in driver
      # redirect_to driver
      # we really should redirect to the main page inside the app
      flash.now[:success] = 'You are logged in'
      render 'new'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end

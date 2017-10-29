class DriverSessionsController < ApplicationController
  
  # skip_before_action :require_login, only: [:new, :create] 
  def new
  end
  
  def create
    driver = Driver.find_by(email: params[:session][:email].downcase)
    if driver && driver.authenticate(params[:session][:password])
      if driver.active
        log_in_driver driver
        redirect_to drivers_shipment_list_path
        flash.now[:success] = 'Welcome driver!'
      else
        redirect_to root_path
        flash.now[:danger] = 'You must be accepted first!'
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
    end
  end

  def destroy
  end
end

class SessionsController < ApplicationController
  
  # skip_before_action :require_login, only: [:new, :create] 
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash.now[:success] = 'You are logged in'
      redirect_to '/shipments/new'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    pp "logout", get_role, logged_in?, logged_in_driver?
    
    if get_role == "user"
      log_out
    else 
      log_out_driver
    end
    redirect_to root_url
  end
end

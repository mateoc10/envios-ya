class DriversController < ApplicationController
  def new
     @driver = Driver.new
  end
  def create
    @driver = Driver.new(driver_params)
    @driver.location = Location.first.id
    if @driver.save
      flash[:success] = "Welcome to the Envios ya!"
      render 'new'
    else
      if :password != :password_confirmation 
        flash.now[:danger] = "Passwords don't match"
      end
      render 'new'
    end
  end
  
  private

    def driver_params
      params.require(:driver).permit(:name, :last_name, :document, :email, :password, :password_confirmation, :license, :avatar, :documentation)
    end
  
  
  
end

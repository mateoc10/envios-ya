class DriversController < ApplicationController
  def new
     @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:success] = "Welcome to the Sample App!"
      render 'new'
    else
      render 'new'
    end
  end
  
  private

    def driver_params
      params.require(:driver).permit(:name, :last_name, :document, :documentation, :email, :password, :password_confirmation)
    end
  
  
  
end

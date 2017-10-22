class DriversController < ApplicationController
  
  def shipment_list
     @shipment_in_progress = Shipment.where(:price => 2323) #cambiar por estado y filtrar solo los de este driver
     @shipment_ended = Shipment.where(:price => 78)
  end
  
  def new
     @driver = Driver.new
  end
  def create
    @driver = Driver.new(driver_params)
    loc = Location.first
    @driver.location = loc
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
      params.require(:driver).permit(:name, :last_name, :document, :email, :password, :password_confirmation, :license, :avatar, :documentation, :location)
    end
  
  
  
end

class DriversController < ApplicationController
  
  # skip_before_action :require_login, only: [:new, :create] 
  
  def shipment_list
     @shipment_in_progress = Shipment.where(:state => 'In progress') #cambiar por estado y filtrar solo los de este driver
     @shipment_deliveder = Shipment.where(:state => 'Delivered')
  end
  
  def shipment
    @shipment = Shipment.find_by_id(params[:id])
    render '../views/drivers/shipment'
  end
  
  def end_shipment()
    @ship = Shipment.find_by_id(params[:shipment_id])
    pp @ship, params[:shipment_id], 'ship'
    @ship.state = 'Delivered'
    @ship.save
    redirect_to '/drivers/shipment_list'
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

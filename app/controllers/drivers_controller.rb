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
  
  def end_shipment(id)
    @ship = Shipment.find_by_id(id)
    @ship.state = 'Delivered'
    @ship.save
  end
  
  def new
     @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(driver_params)
    loc = Location.first
    @driver.location = loc
    if @driver.save
      flash[:success] = "Before starting to use EnviosYarq, you have to be accepted"
      redirect_to root_path
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

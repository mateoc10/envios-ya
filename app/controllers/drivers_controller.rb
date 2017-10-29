class DriversController < ApplicationController
  
  # skip_before_action :require_login, only: [:new, :create] 
  before_action only: [:shipment_list, :shipment, :end_shipment] do 
    require_login("driver")
  end
  
  def shipment_list
     @shipment_in_progress = Shipment.where(:state => 'In Progress' , :driver_id => current_driver.id) 
     @shipment_deliveder = Shipment.where(:state => 'Delivered', :driver_id => current_driver.id) 
  end
  
  def shipment
    @shipment = Shipment.find_by_id(params[:id])
    render '../views/drivers/shipment'
  end
  
  def end_shipment()
    @ship = Shipment.find_by_id(params[:shipment_id])
    @ship.state = 'Delivered'
    @ship.save
    
    @driver = @ship.driver;
    pp "driver", @driver
    @driver.available = true;
    @driver.location = @ship.destination;
    @ship.driver.save(validate: false)
    redirect_to '/drivers/shipment_list'
  end
  
  def new
     @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(driver_params)
    loc = Location.first
    @driver.location = loc
    @driver.available = true
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

class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
  end
  
  def create
    @shipment = Shipment.new(shipment_params)
    
    @shipment.state = 'In Progress'
    @shipment.date = Date.now
    if @user.save
      flash.now[:success] = "Welcome to Envios ya!"
      # render 'new'
    else
      if :password != :password_confirmation 
        flash.now[:danger] = "Passwords don't match"
      end
      render 'new'
    end
  end

  private

    def shipment_params
      params.require(:shipment).permit(:price, :payment, :date, )
    end
  
end

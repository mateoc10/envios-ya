class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
  end
  
  def create
    @shipment = Shipment.new(shipment_params)
    origin = create_location(-34.881725, -56.073983)
    destination = create_location(-34.927254, -56.158236)
    byebug
    @shipment.state = 'In Progress'
    @shipment.date = DateTime.now
    if @shipment.save
      flash.now[:success] = "Welcome to Envios ya!"
       render 'new'
    else
      if :password != :password_confirmation 
        flash.now[:danger] = "Passwords don't match"
      end
      render 'new'
    end
  end

  private

    def shipment_params
      params.require(:shipment).permit(:price, :payment, :date, :driver, :destination, :sender, :receiver, :origin)
    end
    
    def create_location(lat, lng)
      geocode = JSON.parse Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng="+ lat.to_s() +"," + lng.to_s() + "&key=AIzaSyCULAfBJit219O85L4mwt4nqVhBL9KARCQ"))
      
      addresses = geocode["results"][0]["address_components"]
      number = ''
      address = ''
      zipcode = ''
      addresses.each { |adr|
        if adr["types"][0] == "route"
          address = adr["long_name"]
        elsif adr["types"][0] == "street_number"
          number = adr["long_name"]
        elsif adr["types"][0] == "postal_code"
          zipcode = adr["long_name"]
        end
      }
      return Location.new(lat: lat, long: lng, street: address, number: number, zipcode: zipcode)
    end
end

class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
  end
  
  def create
    @shipment = Shipment.new(shipment_params)
    origin = create_location(-34.881725, -56.073983)
    destination = create_location(-34.927254, -56.158236)
    @shipment.state = 'In Progress'
    @shipment.date = DateTime.now
    if @shipment.save
      flash.now[:success] = "Welcome to Envios ya!"
       render 'new'
    else
      flash.now[:danger] = :user.errors
      render 'new'
    end
  end
  
  def receive_locations
    list = params['markerList']
    # @shipment.origin = create_location(list["0"]["lat"], list["0"]["lng"])
    # @shipment.destination = create_location(list["1"]["lat"], list["1"]["lng"])
    calculate_price
    get_near_drivers
  end

  private

    def shipment_params
      params.require(:shipment).permit(:price, :payment, :date, :driver, :destination, :sender, :receiver, :origin)
    end
    
    def calculate_price
      @shipment.price = 100;
    end
    
    def get_near_drivers
      
    end
    
    def create_location(lat, lng)
      geocode = JSON.parse Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng="+ lat +"," + lng + "&key=AIzaSyCULAfBJit219O85L4mwt4nqVhBL9KARCQ"))
      
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

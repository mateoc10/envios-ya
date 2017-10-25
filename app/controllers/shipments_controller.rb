class ShipmentsController < ApplicationController
  
  before_action :init_shipment
  
  def init_shipment
    @Shipment ||= Shipment.new
  end
  
  def new
    @shipment = Shipment.new
  end
  
  def details
    @Shipment.origin = Location.first
    @Shipment.destination = Location.second
    @Shipment.price = 100
    # @halfShipment = params[:shipment]
    @near_drivers = [Driver.first.name, Driver.second.name, Driver.third.name] #params[:nearDrivers]
    render "../views/shipments/shipment_details"
  end
  
  def create
    @Shipment = Shipment.new
    @Shipment.origin = Location.first
    @Shipment.destination = Location.second
    @Shipment.price = 100
    @Shipment.status = 'In Progress'
    @Shipment.date = DateTime.now
    @Shipment.sender = current_user
    pp 'ship', @Shipment
    if @Shipment.save
      flash.now[:success] = "Welcome to Envios ya!"
    else
      flash.now[:danger] = 'error'#:shipments.errors
    end
  end
  
  def receive_locations
    @shipment = Shipment.new
    list = params['markerList']
    originLoc = create_location(list["0"]["lat"], list["0"]["lng"])
    destinationLoc = create_location(list["1"]["lat"], list["1"]["lng"])
    originLoc.save
    destinationLoc.save
    @origin = originLoc
    @destination = destinationLoc
    @price = calculate_price
    @near_drivers = get_near_drivers(list["0"]["lat"], list["0"]["lng"])
  end
  
  def get_near_drivers(lat, lng)
    driver1, driver2, driver3 = nil
    d1, d2, d3 = nil
    Driver.includes(:location).all.each do |d|
      distance = Geocoder::Calculations.distance_between([lat.to_f,lng.to_f], [d.location.lat,d.location.long])
      if d3 == nil || distance < d3
        if d2 == nil || distance < d2
          if d1 == nil || distance < d1
            d3 = d2 
            driver3 = driver2
            d2 = d1
            driver2 = driver1
            d1 = distance
            driver1 = d
          else
            d3 = d2
            driver3 = driver2
            d2 = distance
            driver2 = d
          end
        else
          d3 = distance
          driver3 = d
        end
      end
    end
  near_drivers = [driver1, driver2, driver3]
  return near_drivers
end

  private

    def shipment_params
      params.require(:shipment).permit(:price, :payment, :date, :driver, :destination, :sender, :receiver, :origin, :weight)
    end
    
    def calculate_price
      @shipment.price = 100;
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

class ShipmentsController < ApplicationController
  def new
    @shipment = Shipment.new
  end
  
  def create
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
    @shipment = Shipment.new
    list = params['markerList']
    originLoc = create_location(list["0"]["lat"], list["0"]["lng"])
    destinationLoc = create_location(list["1"]["lat"], list["1"]["lng"])
    originLoc.save
    destinationLoc.save
    @shipment.origin = originLoc
    @shipment.destination = destinationLoc
    calculate_price
    get_near_drivers(list["0"]["lat"], list["0"]["lng"])
  end
  
  
  def get_near_drivers(lat, lng)
    driver1, driver2, driver3 = -1
    d1, d2, d3 = -1
    origin = GeoKit::Latlng.new(lat, lng)
    allD = Driver.include(:location)
    pp "allD", allD
    allD.all.each do |d|
        distance = origin.distance_to(d.location.lat, d.location.long)
        if d3 != -1 && distance < d3
          if d2 != -1 && distance < d2
            if d1 != -1 && distance < d1
              d3 = d2 
              driver3 = driver2
              d2 = d1
              driver2 = driver1
              d1 = distance
              driver1 = d.id
            else
              d3 = d2
              driver3 = driver2
              d2 = distance
              driver2 = d.id
            end
          else
            d3 = distance
            driver3 = d.id
          end
        end
      end
    near_drivers = [driver1, driver2, driver3]
    pp 'shoco', near_drivers
    return near_drivers
  end

  private

    def shipment_params
      params.require(:shipment).permit(:price, :payment, :date, :driver, :destination, :sender, :receiver, :origin)
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

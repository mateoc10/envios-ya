class ShipmentsController < ApplicationController
  
  before_action :init_shipment
  
  def init_shipment
    @Shipment ||= Shipment.new
  end
  
  def new
    @shipment = Shipment.new
  end
  
  def details
    
    originLoc = create_location(params[:originLat], params[:originLng])
    destinationLoc = create_location(params[:destinationLat], params[:destinationLng])
    @Shipment.origin = originLoc
    @Shipment.destination = destinationLoc
    # @halfShipment = params[:shipment]
    @near_drivers = get_near_drivers(params[:originLat], params[:originLng])
    render "../views/shipments/shipment_details"
  end
  
  def create
    pp "params", params
    @Shipment = Shipment.new(user_params)
    originLoc = create_location(params[:originLat], params[:originLng])
    destinationLoc = create_location(params[:destinationLat], params[:destinationLng])
    originLoc.save
    destinationLoc.save
    @Shipment.origin = originLoc
    @Shipment.destination = destinationLoc
    @Shipment.state = 'In Progress'
    @Shipment.date = DateTime.now
    @Shipment.sender = current_user
    @Shipment.driver = Driver.find_by_id(params[:shipment][:driver])
    @Shipment.price = 100
    
    @user = User.find_by_id(current_user.id)
    
    if @user.discounts > 0
      @Shipment.price = @Shipment.price / 2
      @user.discounts -= 1
      @user.save(validate: false)
    end
    
    pp "first", current_user
    if current_user.new_user
      if current_user.invitee != nil
        @invitee = User.find_by_id(current_user.invitee)
        @invitee.discounts = @invitee.discounts + 1
        @invitee.save(validate: false)
      end
      @user.new_user = false
      @user.save(validate: false)
    end
    
    pp "second", current_user
    
    receiver = User.find_by_email(params[:receiver])
    if receiver != nil
      @Shipment.receiver = receiver
    else 
      receiver = User.new do |u|
        u.email = params[:receiver]
        u.name = "a"
        u.password = "12345678"
      end
      receiver.save
      @Shipment.receiver = receiver
      UserMailer.welcome_email(@Shipment.receiver.email, @Shipment.sender.id).deliver_now
    end
    if @Shipment.save
      flash.now[:success] = "Success!"
    else
      flash.now[:danger] = 'error'#:shipments.errors
    end
  end
  
  def receive_locations
    @shipment = Shipment.new
    list = params['markerList']
    
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
    
    def user_params
      params.require(:shipment).permit(:weight, :payment)
    end
end

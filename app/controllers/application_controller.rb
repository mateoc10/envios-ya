class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include DriverSessionsHelper
 
  def require_login(role)
    unless logged_in? && role == "user" || logged_in_driver? && role == "driver"
      flash[:error] = "Debe loguearse para utilizar esta funcionalidad"
      redirect_to root_path
    end
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
  
  def hello
    
  end
end

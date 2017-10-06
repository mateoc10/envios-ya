class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def hello
    render :template => '/../views/layouts/application.html.erb'
  end
end

class LayoutController < ApplicationController
  
  skip_before_action :require_login, only: [:home] 
  def home
    render :template => '/../views/static_pages/home.html.erb'
  end
end

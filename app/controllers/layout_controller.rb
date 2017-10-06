class LayoutController < ApplicationController
  def home
    render :template => '/../views/static_pages/home.html.erb'
  end
end

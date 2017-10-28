class AdminsController < ApplicationController
helper_method :approve
helper_method :reject
    
  def new
    @admin = Admin.new
  end

    def create
        flash[:success] = "Welcome to Envios ya!"
    end
    
    def confirm_driver
       @nil_drivers = Driver.where(:active => nil)
    end
    
    
    def approve()
      d = Driver.find_by_id(4)
      d['active'] = true
      d.active = true
      d.save
    end
    
    def reject()
      dr = Driver.find_by_id(4)
      dr['active'] = false
      dr.active = false
      dr.save
    end
end

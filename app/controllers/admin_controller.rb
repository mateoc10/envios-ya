class AdminController < ApplicationController
  
  helper_method :approve
    
  def new
    @admin = Admin.new
  end

    def create
        flash[:success] = "Welcome to Envios ya!"
    end
    
    def approve(idDriv)
      d = Driver.find_by_id(1)
      d['active'] = true
      d.save
      
    end
    
    def reject(idDriv)
      d = Driver.find_by_id(1)
      d['active'] = false
      d.save
    end
    

end


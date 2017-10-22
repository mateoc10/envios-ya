class AdminsController < ApplicationController
helper_method :approve
helper_method :reject
    
  def new
    @admin = Admin.new
  end

    def create
        flash[:success] = "Welcome to Envios ya!"
    end
    
    # def approve()
    #   d = Driver.find_by_id(1)
    #   d['active'] = true
    #   d.save
    #   flash[:success] = "entro approve"
    # end
    
    def reject()
      dr = Driver.find_by_id(1)
      dr['active'] = false
      dr.save
      flash[:success] = "entro reject"
    end
end

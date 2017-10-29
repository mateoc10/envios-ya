class AdminsController < ApplicationController
helper_method :approve
helper_method :reject
    
  
  def new
    @admin = Admin.new
  end
  
  def login
    user = params[:username]
    pass = params[:password]
    if user == 'admin' && pass == 'admin'
      flash[:success] = "Welcome admin"
      redirect_to '/admins/confirm_driver' 
    else
      render 'new'
      flash[:danger] = "username or password incorrect"
    end
  end

    def create
        flash[:success] = "Welcome to Envios ya!"
    end
    
    def confirm_driver
       @nil_drivers = Driver.where(:active => nil)
    end
    
    
    def approve()
      @d = Driver.find_by_id(params[:id])
      @d['active'] = true
      @d.active = true
      @d.save
      redirect_to '/admins/confirm_driver'
    end
    
    def reject()
      @dr = Driver.find_by_id(params[:id])
      @dr['active'] = false
      @dr.active = false
      @dr.save
      redirect_to '/admins/confirm_driver'
    end
end

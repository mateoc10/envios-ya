class UsersController < ApplicationController
  
  helper_method :get_user_by_id
  helper_method :get_users_by_mail
  
  def new
    @user = User.new
  end
  
  def get_users_by_mail
    return User.select('email')
  end
  
  
  def create
    @user = User.new(user_params)
    invitee = params[:invitee]
    @user.new_user = true
    if invitee && invitee != "-1"
      @user.invitee = invitee
      @user.discounts = 1
    end
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Envios ya!"
      #UserMailer.welcome_email(@user).deliver_now
      redirect_to '/shipments/new'
    else
       flash.now[:danger] =  @user.errors.messages[:document]
      # flash.now[:danger] = "Passwords don't match"
    end
  end
  
  def get_user_by_id(id)
    usr = User.find_by_id(id)
    if usr != nil
      return "Invited by " + usr["name"] + " " + usr["lastName"]
    else 
      return ""
    end
  end




  private

    def user_params
      params.require(:user).permit(:name, :lastName, :document, :email, :password, :password_confirmation, :avatar)
    end
end

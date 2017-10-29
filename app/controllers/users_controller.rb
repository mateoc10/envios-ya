class UsersController < ApplicationController
  
  # skip_before_action :require_login, only: [:new, :create] 
  
  
  
  helper_method :get_user_by_id
  
  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(user_params)
    invitee = params[:invitee]
    @user.discounts = 0
    if invitee && invitee != "-1"
      @invitedUser = User.find_by_email(@user.email)
      @invitedUser.name = @user.name
      @invitedUser.lastName = @user.lastName
      @invitedUser.document = @user.document
      @invitedUser.email = @user.email
      @invitedUser.password = @user.password
      @invitedUser.password_confirmation = @user.password_confirmation
      
      @user = @invitedUser
      @user.invitee = invitee
      @user.discounts = 1
    end
    @user.new_user = true
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Envios ya!"
      # UserMailer.welcome_email("mateoc10@gmail.com", 1).deliver_now
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

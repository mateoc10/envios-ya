class UsersController < ApplicationController
  
  helper_method :get_user_by_id
  
  def new
    @user = User.new
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
      flash[:success] = "Welcome to Envios ya!"
      # render 'new'
    else
      if :password != :password_confirmation 
        flash.now[:danger] = "Passwords don't match"
      end
      render 'new'
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

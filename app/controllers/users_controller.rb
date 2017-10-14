class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Envios ya!"
      UserMailer.welcome_email(@user).deliver
      render 'new'
    else
      if :password != :password_confirmation 
        flash.now[:danger] = "Passwords don't match"
      end
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :lastName, :document, :email, :password, :password_confirmation, :avatar)
    end
end

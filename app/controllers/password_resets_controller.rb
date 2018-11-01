class PasswordResetsController < ApplicationController

  before_action :get_user , only: [:edit,:update]
  before_action :valid_user , only: [:edit,:update]
  before_action :check_expiration, only: [:edit,:update]

  def new
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Email sent with password instructions"
  		redirect_to root_path
  	else
  		flash.now[:danger] = "Email address is not found"
  		render 'new'
  	end
  	
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "Cannot be empty")
      render 'edit'
    elsif @user.update_attributes(user_params_validator)
      log_in @user
      flash[:success] = "Password has been successfully reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
   
    def user_params_validator
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Since we know both edit and update requires the use of @user object. Might as well make it as a before action method.
    def get_user 
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset,params[:id]))
        redirect_to root_path
      end
    end

    def check_expiration
      true
    end

end

class PasswordResetsController < ApplicationController

  before_action :get_user , only: [:edit,:update]
  before_action :valid_user , only: [:edit,:update]

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

  private
    # Since we know both edit and update requires the use of @user object. Might as well make it as a before action method.
    def get_user 
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      puts @user 
      puts params[:id]
      unless (@user && @user.activated? && @user.authenticated?(:reset,params[:id]))
        redirect_to root_path
      end
    end

end

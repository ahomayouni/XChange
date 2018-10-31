class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params_validator)
  	if @user.save
  		flash[:success] = "Thanks for signing up with XChange!"
  		redirect_to login_path
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  	def user_params_validator
  		params.require(:user).permit(:name, :email,:password,:password_confirmation)
  	end
end

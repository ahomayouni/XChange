class UsersController < ApplicationController
  before_action :verify_logged_in_user, only: [:show,:edit,:update] # White listing
  before_action :verify_correct_user, only: [:show,:edit,:update] # White listing

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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_validator)
      flash[:success] = "Successfully updated your profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def user_params_validator
  		params.require(:user).permit(:name, :email,:password,:password_confirmation)
  	end

    def verify_logged_in_user
      unless logged_in? 
        flash[:danger] = "Unauthorized Access. Please log in."
        redirect_to login_path
      end
    end

    def verify_correct_user
      @user = User.find(params[:id])
      if not @user == current_user
        flash[:danger] = "Unauthorized Access."
        redirect_to current_user
      end

    end

end

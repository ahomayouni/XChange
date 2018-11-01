class UsersController < ApplicationController
  before_action :verify_logged_in_user, only: [:index,:edit,:update] # White listing
  before_action :verify_correct_user, only: [:edit,:update] 
  before_action :verify_admin_user, only: :destroy #only admin can issue a destroy command

  def index
    # @users = User.all # Caution doing this might slow down some rendering in the future
    @users = User.paginate(page: params[:page])
   
    # Search functionality for users  
    if params[:search_users] and params[:search_users] != ""
      @users_found = User.search(params[:search_users])
    else
      nil
    end
  end
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params_validator)
  	if @user.save
      UserMailer.account_activation(@user).deliver_now
  		flash[:success] = "Thanks for signing up with XChange! Now please check your email to activate"
  		# redirect_to login_path
      redirect_to root_path
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User has been successfully deleted"
    redirect_to users_path #Reload page with another request
  end

  private

    # Important to note that :admin is not included here. MEANING outsider are not allowed to send an admin
    # params here. It could only be set through with access to the heroku database. 
  	def user_params_validator
  		params.require(:user).permit(:name, :email,:password,:password_confirmation)
  	end

    def verify_admin_user
      if !current_user.admin?
        redirect_to users_path
      end
    end

end

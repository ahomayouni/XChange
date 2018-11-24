class UsersController < ApplicationController
  before_action :verify_logged_in_user, only: [:index,:edit,:update,:show] # White listing
  before_action :verify_correct_user, only: [:edit,:update] 
  before_action :verify_admin_user, only: :destroy #only admin can issue a destroy command
  before_action :force_json, only: :autocomplete_users

  def index
    @users = User.paginate(page: params[:page])
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
      @user.create_person #Creating a person object associated with this user.
      UserMailer.account_activation(@user).deliver_now
      Notification.create(recipient: @user,actor: @user,action:"created_new_account",notifiable:@user)
  		flash[:success] = "Thanks for signing up with XChange! Now please check your email to activate"
      redirect_to root_path
  	else
  		flash.now[:danger] = "The signup form was put in incorrectly."
  		render 'home/index'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    @user.name = params[:user][:name]
    @user.person.address = params[:user][:address]
    @user.person.phone_number = params[:user][:phone_number]
    @user.person.description = params[:user][:description]
    @user.person.image = params[:user][:image]

    @user.password = ''
    @user.password_confirmation = ''

    if @user.save
      @user.person.save
      flash[:success] = "Successfully updated your profile!"
      redirect_to user_settings_path(@user)
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

  def search_users
      @users_found = User.ransack(name_cont: params[:users_q]).result(distinct: true)
  end
    
  def autocomplete_users
    @users_found = User.ransack(name_cont: params[:users_q]).result(distinct: true)

      respond_to do |format|
      format.html{}
      format.json{
        @users_found = @users_found.limit(5)
      }
    end
  end

  def send_reminders
    flash[:success] = "Example of a scheduler reminder!"
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
    
    #to ensure "/search_user" is allowed as well as "/search_user.json"
    def force_json
      request.format = :json
    end

end

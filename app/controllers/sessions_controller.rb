class SessionsController < ApplicationController
  def new
  end

  def create
  	
  	user = User.find_by(email: params[:session][:email].downcase) #make email string uniform as before_save in db
  	if user && user.authenticate(params[:session][:password])
  		if user.activated?
        log_in(user)
        # Whether to use cookies or not
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user_path(user,active_tab: "dashboardTab")
      else
        flash[:warning] = "Account not activated. Please check your email for the activation link. Also please check your spam!"
        # redirect_to root_path
      end

  	else
  		flash.now[:danger] = "Invalid email/password combination! Please try again"
  		render 'home/index'
  	end

  end

  def destroy
    log_out if logged_in? # Do this to prevent bug when user have multiple browsers opened and logsout in one of them
    redirect_to root_path
  end
end

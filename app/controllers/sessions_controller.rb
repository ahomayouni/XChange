class SessionsController < ApplicationController
  def new
  end

  def create
  	
  	user = User.find_by(email: params[:session][:email].downcase) #make email string uniform as before_save in db
  	if user && user.authenticate(params[:session][:password])
  		log_in user #call function log_in provided in sessions_helper 
      remember user #call function remember provided in sessions_helper
  		redirect_to user 
  	else
  		flash.now[:danger] = "Invalid email/password combination! Please try again"
  		render 'new'
  	end

  end

  def destroy
    log_out if logged_in? # Do this to prevent bug when user have multiple browsers opened and logsout in one of them
    redirect_to root_path
  end
end

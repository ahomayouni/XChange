class SessionsController < ApplicationController
  def new
  end

  def create
  	
  	user = User.find_by(email: params[:session][:email].downcase) #make email string uniform as before_save in db
  	if user && user.authenticate(params[:session][:password])
  		log_in user #call function log_in provided in sessions_helper 
      
      # Only save the cookies iff the remember me is set to 1
      # Actually by default it's going to always be "Remember me"
      # https://stackoverflow.com/questions/6837620/in-rails-how-do-you-destroy-a-session-when-a-browser-is-closed
      # Cookies setting is working fine though.
      if params[:session][:remember_me] == '1'
        remember(user)
      else
        forget(user)
      end

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

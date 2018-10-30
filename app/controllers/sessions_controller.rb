class SessionsController < ApplicationController
  def new
  end

  def create
  	# We have downcase here since before saving to database we are downcasing the email address
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		redirect_to user 
  	else
  		flash[:danger] = "Invalid email/password combination! Please try again"
  		render 'new'
  	end

  end
end

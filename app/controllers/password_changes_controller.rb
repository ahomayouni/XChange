class PasswordChangesController < ApplicationController
	def new
		@user = User.find(params[:user_id])
	end

	def create
		@user = User.find(params[:user_id])
		@user.password = params[:password_changes][:password]
		@user.password_confirmation = params[:password_changes][:password_confirmation]

		if @user.save 
			flash[:success] = "Succeded in changing password!"
			redirect_to @user 
		else
			render 'new'
		end
	end
end

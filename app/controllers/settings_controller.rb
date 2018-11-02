class SettingsController < ApplicationController
	def index
		puts params[:user_id]
		@user = User.find(params[:user_id])
	end

	def destroy
		@user = User.find(params[:user_id])
    	@user.destroy
    	log_out if logged_in? # Do this to prevent bug when user have multiple browsers opened and logsout in one of them
    	redirect_to root_path
	end
end

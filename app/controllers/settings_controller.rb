class SettingsController < ApplicationController
	before_action :verify_logged_in_user
	before_action :find_user
	before_action :verify_correct_user_settings, only: [:index,:destroy]

	def index
	end

	
	def destroy
		@user = User.find(params[:user_id])
    	@user.destroy
    	log_out if logged_in? # Do this to prevent bug when user have multiple browsers opened and logsout in one of them
    	redirect_to root_path
	end

	private

     def find_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      end
    end

    def verify_correct_user_settings
    	if not @user == current_user
    		flash[:danger] = "Unauthorized Access."
        	redirect_to current_user
      	end 
    end


end

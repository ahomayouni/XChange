module SessionsHelper
	
	# Creates a session variable whenever a user logs in.
	# Temp cookies created using the session method are automatically encrypted
	# This is secure. No way for an attacker to use the session information to log in as user
	def log_in(user)
		session[:user_id] = user.user_id
	end

	# Returns a User object based on the session[:user_id] or current user logged in
	# This is handy because now we can simply do <%= current_user.name %> in views and
	# redirect_to current_user within the controller
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end

end

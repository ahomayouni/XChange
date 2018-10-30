module SessionsHelper
	
	# Creates a session variable whenever a user logs in.
	# Temp cookies created using the session method are automatically encrypted
	# This is secure. No way for an attacker to use the session information to log in as user
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns a User object based on the session[:user_id] or current user logged in
	# This is handy because now we can simply do <%= current_user.name %> in views and
	# redirect_to current_user within the controller
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id == cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	### Cookies Helper Functions

	# Set information to user column in database and set cookies
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id 
		cookies.permanent[:remember_token] = user.remember_token	
	end

	# Set information to user column in database to nil and set cookies
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Returns true if a user is logged in. 
	def logged_in?
		!current_user.nil?
	end

	# Deletes current session and set @current_user to nil
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
end

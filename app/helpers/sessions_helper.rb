module SessionsHelper
	def log_in(user)
		# Temp cookies created using the session method are automatically encrypted
		# This is secure. No way for an attacker to use the session information to log in as user
		session[:user_id] = user.user_id
	end
end

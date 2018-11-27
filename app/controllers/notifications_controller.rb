class NotificationsController < ApplicationController
	skip_before_action :verify_authenticity_token , raise: false
	before_action :verify_logged_in_user

	def index
		@notifications = Notification.where(recipient: current_user).recent
	end
	def mark_as_read 
		puts "HEEEEERRRRREEEEEEEEEEEE"
		@notifications = Notification.where(recipient: current_user).unread
		@notifications.update_all(read_at: Time.now)
		render json: {success:true}
	end
	
end

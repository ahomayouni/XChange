class NotificationsController < ApplicationController
	skip_before_action :verify_authenticity_token , raise: false
	before_action :verify_logged_in_user

	def index
		puts "CALLLLLEEEEDDDDD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		@all_notifications = Notification.where(recipient: current_user).recent

		# Clean Broken notifications if any
		@broken_notifications = @all_notifications.select {|current_notif| current_notif.notifiable.nil? == true}
		@broken_notifications.each do |cur_broken_notif|
			cur_broken_notif.destroy 
		end
		# Get only the good one
		@notifications = Notification.where(recipient: current_user).recent
	end
	def mark_as_read
		puts "CALLLLLEEEEDDDDD $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		@notifications = Notification.where(recipient: current_user).unread
		@notifications.update_all(read_at: Time.now)
		render json: {success:true}
	end
	
end

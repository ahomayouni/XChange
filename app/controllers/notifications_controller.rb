class NotificationsController < ApplicationController
	before_action :verify_logged_in_user

	def index
		@notifications = Notification.where(recipient: current_user).unread
	end
end

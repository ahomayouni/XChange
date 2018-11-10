json.array! @notifications do |notification|
	json.actor notification.actor
	json.action notification.action
	json.notifiable do #notification.notifiable
    	json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  	end
	# json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
end
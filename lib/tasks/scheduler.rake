desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  # might have to change this with status borrowed later 
  @approved_items = BorrowRequest.where(status:"approved")
  puts "There are #{@approved_items.all.count} items currently being borrowed"
  @approved_items.each do |item| 
	  	@borrower = User.find(item.user_id)
	  	if item.end_borrowing.past?
	  		# Late
	    if Notification.where(actor_id: @borrower.id, recipient: @borrower , action: "systems_listing_reminder_past_due", notifiable: item).count == 0 
		  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_past_due",notifiable: item)
		        @new_notif.save
		        puts "Sending notification for something past due"
		    else
		    	puts "The system have already sent out the notification"
		    end
	  	elsif item.end_borrowing.today?
	  		# Due Today
	    	if Notification.where(actor_id: @borrower.id, recipient: @borrower , action: "systems_listing_reminder_due_today", notifiable: item).count == 0 
		  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_today",notifiable: item)
		        @new_notif.save
		        puts "Sending notification for something due today"
		    else
		    	puts "The system have already sent out the notification"
		    end

	  	elsif (item.end_borrowing - 1).today?
	  		# Due Tomorrow
	  		# Check if the system has sent out the notifications
	  		if Notification.where(actor_id: @borrower.id, recipient: @borrower , action: "systems_listing_reminder_due_tomorrow", notifiable: item).count == 0 
		  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_tomorrow",notifiable: item)
		        @new_notif.save
		        puts "Sending notification for something due tomorrow"
		    else
		    	puts "The system have already sent out the notification"
		    end
	  	elsif (item.end_borrowing - 2.days).today?
	  		# Due in Two days
	  		if Notification.where(actor_id: @borrower.id, recipient: @borrower , action: "systems_listing_reminder_due_in_two_days", notifiable: item).count == 0 
		  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_in_two_days",notifiable: item)
		        @new_notif.save
		        puts "Sending notification for something due in two days"
		    else
		    	puts "The system have already sent out the notification"
		    end
	  	else
	  		puts "This item is not due yet"
	  	end
  end
end
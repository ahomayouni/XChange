desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  
  # might have to change this with status borrowed later 
  @approved_items = BorrowRequest.where(status:"approved")
  puts "There are #{@approved_items.all.count} items currently being borrowed"
  @approved_items.each do |item| 
	  	@borrower = User.find(item.user_id)
	  	if item.end_borrowing.past?
	  		# Late
	  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_past_due",notifiable: item)
	        @new_notif.save 
	  	elsif item.end_borrowing.today?
	  		# Due Today
	  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_today",notifiable: item)
	        @new_notif.save
	  	elsif (item.end_borrowing - 1).today?
	  		# Due Tomorrow
	  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_tomorrow",notifiable: item)

	        @new_notif.save
	        puts @new_notif.errors.full_messages
	  	elsif (item.end_borrowing - 2).today?
	  		# Due in Two days
	  		@new_notif = Notification.new(recipient: @borrower, actor_id: @borrower.id ,action: "systems_listing_reminder_due_in_two_days",notifiable: item)
	        @new_notif.save
	        puts @new_notif.errors.full_messages
	  	else
	  		puts "Nothing due soon !"
	  	end
  end
end
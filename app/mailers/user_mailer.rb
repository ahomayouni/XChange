class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate your Account!"
  end

  def password_reset(user)
    @user = user 
    mail to: user.email, subject: "Password Reset"
  end

  def late_reminder(borrow_request)
    puts "INSIDE LATE_REMINDERRRRRRRRRRR"
    @user = User.where(id: borrow_request.user_id)
    @borrow_request = borrow_request
    @late_item = Listing.where(id: borrow_request.listing_id)

    if not @user.count == 0 and not @late_item.count == 0
      @late_item = @late_item[0]
      @user = @user[0]
      @item_owner = User.where(id: @late_item.user.id)
      if not @item_owner.count == 0
        @item_owner = @item_owner[0]
  	     mail to: @user.email, subject: "Late Item Due"
       else
        puts "Urgh why is the item owner unable to find"
      end
    else
      puts "UH oh cant find the user or item .. this is weird"
    end
  end
end

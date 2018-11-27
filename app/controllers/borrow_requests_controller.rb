class BorrowRequestsController < ApplicationController
  def send_request
    # puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    # puts params[:borrow_request][:date_range].split(" - ")[0]
    # puts params[:borrow_request][:date_range].split(" - ")[1]
    # puts ">>>>>>>>>>>>>>>>>>>>>>>>"

      if BorrowRequest.exists?(listing_id: params[:listing_id], user_id: current_user.id)
        flash[:danger] = "Already requested"
        redirect_to listings_path
      else
        start_b = params[:borrow_request][:date_range].split(" - ")[0].split("/")
        @start_borrowing = DateTime.new(start_b[0].to_i, start_b[1].to_i, start_b[2].to_i)
        end_b = params[:borrow_request][:date_range].split(" - ")[1].split("/")
        @end_borrowing = DateTime.new(end_b[0].to_i, end_b[1].to_i, end_b[2].to_i)

        @new_request = BorrowRequest.new(listing_id: params[:listing_id], user_id: current_user.id, status: "requested", start_borrowing: @start_borrowing, end_borrowing: @end_borrowing)
        if @new_request.save
          @current_listing = Listing.find(params[:listing_id])
          @notif_recipient = User.find(@current_listing.user_id)
          @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "borrow_request",notifiable: @current_listing)
          @new_notif.save
          @chatroom = Chatroom.create(borrow_request_id: @new_request.id)
          @listing_user = @current_listing.user_id
          @chatroom.user_ids = [current_user.id, @listing_user]
          inital_message = 'I would like to talk about ' + @current_listing.title
          @chatroom.messages.create(content: inital_message, user_id: current_user.id)
          @chatroom.save
          flash[:borrow_request_sucess] = "Borrow Request Successfull"
          redirect_to listings_path
        else
          flash[:danger] = "Borrow Request Unsuccessfull"
          redirect_to listings_path
        end
      end
    end

  def delete_request
    if BorrowRequest.exists?(id: params[:id])
      BorrowRequest.find_by(id: params[:id]).destroy
      flash[:success] = "Borrow Request Deleted"
    else
      flash[:danger] = "Borrow Request could not be deleted"
    end
    # TODO: change the redirect to a more approproate listing
    redirect_to user_path(current_user,active_tab: "borrowRequests")
    
  end

  def approve
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "approved"
    @borrow_request.save
    @notif_recipient = User.find(@borrow_request.user_id)
    @current_listing = Listing.find(@borrow_request.listing_id)
    @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "request_approved",notifiable: @current_listing)
    @new_notif.save

    check = BorrowRequest.where(listing_id: @borrow_request.listing_id, status: "requested").where.not(id: @borrow_request.id)
    check.each do |i|
      unless @borrow_request.end_borrowing < i.start_borrowing || @borrow_request.start_borrowing > i.end_borrowing
        @decline_request = BorrowRequest.find_by(id: i.id)
        @decline_request.status = "declined"
        @decline_request.save
        @notif_recipient = User.find(@decline_request.user_id)
        @current_listing = Listing.find(@decline_request.listing_id)
        @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "request_declined",notifiable: @current_listing)
        @new_notif.save
      end
    end
    redirect_to user_path(current_user,active_tab: "actionItems")
  end

  def decline
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "declined"
    @borrow_request.save
    @notif_recipient = User.find(@borrow_request.user_id)
    @current_listing = Listing.find(@borrow_request.listing_id)
    @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "request_declined",notifiable: @current_listing)
    @new_notif.save
    redirect_to user_path(current_user,active_tab: "actionItems")
  end

  def borrowed
  end

  def returned
  end

end

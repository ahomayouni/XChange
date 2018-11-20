class BorrowRequestsController < ApplicationController
  def send_request
      if BorrowRequest.exists?(listing_id: params[:listing_id], user_id: current_user.id)
        flash[:notice] = "Alrerady requested"
        redirect_to listings_path
      else
        @new_request = BorrowRequest.new(listing_id: params[:listing_id], user_id: current_user.id, status: "requested")
        if @new_request.save


          @current_listing = Listing.find(params[:listing_id])
          @notif_recipient = User.find(@current_listing.user_id)
          @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "borrow_request",notifiable: @current_listing)
          @new_notif.save

          flash[:notice] = "Borrow Request Successfull"
          redirect_to listings_path
        else
          flash[:notice] = "Borrow Request Unsuccessfull"
      redirect_to listings_path
        end
      end
    end

  def delete_request
    if BorrowRequest.exists?(id: params[:id])
      BorrowRequest.find_by(id: params[:id]).destroy
      flash[:notice] = "Borrow Request Deleted"
    else
      flash[:notice] = "Borrow Request could not be deleted"
    end
    # TODO: change the redirect to a more approproate listing
    redirect_to current_user
  end

  def approve
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "approved"
    @borrow_request.save
    redirect_to current_user
  end

  def decline
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "declined"
    @borrow_request.save
    redirect_to current_user
  end

  def borrowed
  end

  def returned
  end

end

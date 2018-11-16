class BorrowRequestsController < ApplicationController
  def send_request
      if BorrowRequest.exists?(listing_id: params[:listing_id], user_id: current_user.id)
        flash[:notice] = "Alrerady requested"
        redirect_to listings_path
      else
        @new_request = BorrowRequest.new(listing_id: params[:listing_id], user_id: current_user.id, status: "requested")
        if @new_request.save
          flash[:notice] = "Borrow Request Successfull"
          redirect_to listings_path
        else
          flash[:notice] = "Borrow Request Unsuccessfull"
      redirect_to listings_path
        end
      end 
    end

  # listings that the user has requested to borrow
  # def requested_listings
  #   @listings = Listing.joins(:borrow_requests).where(borrow_requests: {status: "requested", user_id: current_user.id})
  # end

  # listings that require the user's approval
  #def need_approval
  #@listings = BorrowRequest.where(status: "requetsed")
  #@listings = Listing.joins(:borrow_requests).where(borrow_requests: {status: "requested"})
  #end
end

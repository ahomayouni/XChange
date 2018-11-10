class BorrowRequestsController < ApplicationController
  def send_request
    # if current_user.user_id == @listing.user_id
    #   flash[:notice] = "Cannot request your own item"
    # else
      # Listing_id, Borrower_id
      @new_request = BorrowRequest.new(listing_id: params[:listing_id], user_id: current_user.id)
      if @new_request.save
        flash[:notice] = "Borrow Request Successfull"
        redirect_to listings_path
      else
        flash[:notice] = "Borrow Request Unsuccessfull"
    redirect_to listings_path
      end
    end
  # end
end

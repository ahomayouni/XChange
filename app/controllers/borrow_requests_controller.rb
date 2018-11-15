class BorrowRequestsController < ApplicationController
  def send_request
      @new_request = BorrowRequest.new(listing_id: params[:listing_id], user_id: current_user.id)
      if @new_request.save
        flash[:notice] = "Borrow Request Successfull"
        redirect_to listings_path
      else
        flash[:notice] = "Borrow Request Unsuccessfull"
    redirect_to listings_path
      end
    end
end

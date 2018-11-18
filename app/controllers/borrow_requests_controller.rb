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

  def delete_request
    if BorrowRequest.exists?(id: params[:id])
      BorrowRequest.find_by(id: params[:id]).destroy
      flash[:notice] = "Borrow Request Deleted"
    else
      flash[:notice] = "Borrow Request could not be deleted"
    end
    # TODO: change the redirect to a more approproate listing
    redirect_to listing_path
  end

  def approve
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "approved"
    @borrow_request.save
    redirect_to listings_path
  end

  def decline
    @borrow_request = BorrowRequest.find_by(id: params[:id])
    @borrow_request.status = "declined"
    @borrow_request.save
    redirect_to listing_path
  end

  def borrowed
  end

  def returned
  end

end

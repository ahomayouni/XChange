module ListingsHelper
	def not_listing_owner
      @current_listing = Listing.find(params[:id])
      if @current_listing.user.id == current_user.id
      	return false
      else
      	return true
      end
  end

  def is_listing_owner
    @current_listing = Listing.find(params[:id])
    if(@current_listing.user.id == current_user.id)
      return true
    else
      return false
    end
  end

  def is_listing_owner_with_params(listing_id)
    @current_listing = Listing.find(listing_id)
    if(@current_listing.user.id == current_user.id)
      return true
    else
      return false
    end
  end

  def get_rounded_rating
    @current_listing = Listing.find(params[:id])
    if @current_listing.rating.nil?
      return 0
    else
      return @current_listing.rating.round
    end
  end

  def has_user_already_requested_to_borrow_listing
    current_listing = Listing.find(params[:id])
    if current_listing.borrow_requests.nil? || current_listing.borrow_requests.count == 0
      return true 
    end 
    
    borrow_request = current_listing.borrow_requests.find(@current_listing.id)
    
    if !borrow_request.nil? && borrow_request.user_id == current_user.id 
      return false 
    else
      return true
    end 
  end 

end

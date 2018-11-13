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
    @current_lisitng = Listing.find(params[:id])
    if @current_lisitng.rating.nil? 
      return 0 
    else 
      return @current_listing.rating.round
    end 
  end 

end

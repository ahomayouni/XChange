module ListingsHelper
	def not_listing_owner
      @current_listing = Listing.find(params[:id])
      if @current_listing.user.id == current_user.id
      	return false
      else
      	return true
      end
    end
end

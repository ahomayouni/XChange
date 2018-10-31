class ListingsController < ApplicationController

  def new
    @listing = Listing.new
  end

  def create
    #render plain: params[:listing].inspect
    @listing = Listing.new(listing_params)
    if @listing.save
      flash[:notice] = "Listing was successfully created"
      redirect_to listing_show(@listing)
    else
      render 'new'
    end
  end

 private
    def listing_params
      params.require(:listing).permit(:title, :description, :category, :start_lending, :end_lending, :price_per_day)
    end
end

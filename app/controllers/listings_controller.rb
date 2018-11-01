class ListingsController < ApplicationController

  before_action :find_user

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
    #@listing = current_user.listings.build
  end

  def create
    #render plain: params[:listing].inspect
    @listing = Listing.new(listing_params)
    #@listing = current_user.listings.build(listing_params)
    if @listing.save
      flash[:notice] = "Listing was successfully created"
      redirect_to listing_path(@listing)
    else
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
     flash[:notice] = "Listing was updated"
     redirect_to listing_path(@listing)
    else
     flash[:notice] = "Listing was not updated"
     render 'edit'
    end
 end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    flash[:notice] = "Listing was deleted"
    redirect_to listings_path
  end

 private

     def find_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      end
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :category, :start_lending, :end_lending, :price_per_day)
    end
end

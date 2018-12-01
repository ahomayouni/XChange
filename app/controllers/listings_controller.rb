class ListingsController < ApplicationController
  before_action :verify_logged_in_user
  before_action :find_user
  #before_action :verify_correct_user, only: [:edit,:update]
  before_action :force_json, only: :autocomplete_listings

  def index
    if params[:filter].present?
      if params[:filter] != "All"
        @listings = Listing.has_category(params[:filter])
      else
        @listings = Listing.all
      end
    else
      @listings = Listing.all
    end
  end

  def new
    #@listing = Listing.new
    @listing = current_user.listings.build
  end

  def create
    #render plain: params[:listing].inspect
    #@listing = Listing.new(listing_params)
    @listing = current_user.listings.build(listing_params)
    results = Geocoder.search(@listing.address)
    if !results.first  #If location is invalid
      flash[:error] = "Can't find location"
    else
      @listing.latitude = results.first.coordinates[0]
      @listing.longitude = results.first.coordinates[1]
    end
    if @listing.save
      flash[:notice] = "Listing was successfully created"
      redirect_to listing_path(@listing)
    else
      puts @listing.errors.full_messages
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
    @listing.images.purge
    @listing.destroy
    flash[:notice] = "Listing was deleted"
    redirect_to listings_path
  end

  def search_listings
    @listings_found = Listing.ransack(title_cont: params[:listings_q]).result(distinct: true)
  end

  def autocomplete_listings
      @listings_found = Listing.ransack(title_cont: params[:listings_q]).result(distinct: true)
        respond_to do |format|
        format.html{}
        format.json{
          @listings_found = @listings_found.limit(5)
        }
      end
  end

  def report
    if params[:id].present? and Listing.exists?(id: params[:id])
      @listing = Listing.find(params[:id])
      if Report.exists?(user_id: @current_user.id, listing_id: @listing.id)
        flash[:danger] = "You have already submitted a report for this listing"
      else
        @report = Report.new
        @report.user_id = @current_user.id
        @report.listing_id = @listing.id
        if @report.save
          flash.now[:success] = "successfully Reported this listing"
        else
          flash.now[:danger] = "Could not report this item"
        end
      end
      render 'show'
    else
      @listings = Listing.all
      render 'index'
    end
  end

 private

     def find_user
      if params[:user_id]
        puts params[:user_id]
        @user = User.find(params[:user_id])
      end
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :category, :lending_range, :start_lending, :end_lending, :address,:latitude,:longitude,:address,images: [])
    end

    def parse_dates(lending_range)
      start_b = lending_range.split(" - ")[0].split("/")
      @start_l = DateTime.new(start_b[0].to_i, start_b[1].to_i, start_b[2].to_i)
      end_b = lending_range.split(" - ")[1].split("/")
      @end_l = DateTime.new(end_b[0].to_i, end_b[1].to_i, end_b[2].to_i)
      return @start_l, @end_l
    end


    #to ensure "/search_listings" is allowed as well as "/search_listings.json"
    def force_json
      request.format = :json
    end


end

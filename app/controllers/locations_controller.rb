class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end
  def show
    @location = Location.find(params[:id]) #id here refers to user_id
  end 
  def new
    @location = current_user.location.new
  end
  def edit
    if params[:id].present? and params[:lat].present? and params[:long].present? and params[:address].present?
      @location = Location.find(params[:id])
      @location.latitude = params[:lat]
      @location.longitude = params[:long]
      @location.address = params[:address]
    end
    if !@location.save
      flash[:error] = "Location could not be updated"
    end
  end
  def create
    @location = current_user.location.create(location_params_validator)
    
    if @location.save 
          flash[:success] = "New Location created"
          redirect_to location_path(current_user.id)
        else
          render 'new'
        end
  end
  def destoy
  end
  private
  def location_params_validator
    params.require(:location).permit(:address, :latitude, :longitude)
  end
end
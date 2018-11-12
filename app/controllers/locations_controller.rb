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
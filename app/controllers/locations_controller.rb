class LocationsController < ApplicationController
  def index
    @locations = nil
  end
  def show
    @location = nil
  end 
  def new
    @location = nil
  end
  def edit
    @location = nil
  end
  def create
    @location = nil
  end
  def destoy
  end
  private
  def location_params_validator
    params.require(:location).permit(:address, :latitude, :longitude)
  end
end
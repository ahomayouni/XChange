class LocationsController < ApplicationController
  def index
    @locations = Location.all
    @location = current_user.location
    if @location # check to see if object exists
      if(params.has_key?(:lat) && params.has_key?(:long) && params.has_key?(:calculated_address)) #If it's a new location
        @latitude = params[:lat]
        @longitude = params[:long]
        @address = params[:calculated_address]
        @location.latitude = @latitude
        @location.longitude = @longitude
        @location.address = @address
        if(params.has_key?(:max_distance))
          @max_distance = params[:max_distance]
        end
        if @location.save
          flash.now[:success] = "Location updated"
          render 'index'
        else # couldn't save location, try again
          flash.now[:error] = "Location could not get updated. Trying again"
          redner 'new' 
        end
      else #If location was created before, at this point location.latitude should have a value
        if @location.latitude and @location.longitude and @location.address # Fields are present. Success!
          #Success: can show everything in the view now!
          if(params.has_key?(:max_distance))
            @max_distance = params[:max_distance]
          end
        else  #object is here but fields are empty. So Try new again
          flash.now[:error] = "A location object exists. But it's empty"
          render 'new'
        end
      end
    else # Object doesn't exists, so make one
      flash.now[:error] = "A location object does not exist yet"
      render 'new'
    end
  end

  def show
    @location = nil
    if @location  # check to see if object exists
        if @location.latitude and @location.longitude and @location.address # Fields are present. we can show it!
          flash.now[:notice] = "SHOW: lat = #{@location.latitude} long = #{ @location.longitude} estimated address = #{@location.address}"
          # Can implemenet show success show here
          # ...
          # ...
          # ...
          # ...

        else  # Object exists but feilds are empty. So try again and create a new one
          flash.now[:error] = "A location object exists. But it's empty"
          render 'new'
        end
    else # Object doesn't exists, so make one
      flash.now[:error] = "A location object does not exist yet"
      render 'new'
    end
  end 

  def new
    @location = Location.new
    current_user.location = @location
    if @location.save
      flash.now[:notice] = "New Location object created for #{current_user.name} with id #{@location.id}"
      render 'index'
    else
      flash.now[:error] = "Could not create a location object"
    end
  end

  def edit #edit will not get used
    @location = nil 
  end

  private
  def location_params_validator
    params.require(:location).permit(:address, :latitude, :longitude)
  end
end

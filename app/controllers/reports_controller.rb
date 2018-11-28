class ReportsController < ApplicationController
  def delete_listing_and_request
  	if Report.exists?(id: params[:id])
  		@report = Report.find_by(id: params[:id])
  		if @report
  			if Listing.exists?(id: @report.listing_id)
  				@listing = Listing.find(@report.listing_id)
  				if @listing
  					@listing.images.purge
				    @listing.destroy
				    @report.destroy
				    flash[:success] = "The reported listing is successfully deleted"
  				end
  			end
  		end
  	end	
  	redirect_to(user_path(current_user,active_tab: "actionItems"))
  end

  def delete_request
  	if Report.exists?(id: params[:id])
  		@report = Report.find_by(id: params[:id])
  		if @report
  			@report.destroy
			flash[:success] = "Request is deleted"
  		end
  	end
  	redirect_to(user_path(current_user,active_tab: "actionItems"))
  end
end

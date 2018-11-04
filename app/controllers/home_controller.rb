class HomeController < ApplicationController
  before_action :force_json, only: :search
  
  def index
  end
  
  def search
    @listings_found = Listing.ransack(params[:q]).result(distinct: true)
    @users_found = User.ransack(params[:q]).result(distinct: true)
  end
  
  private 
  
  #to ensure "/search" is allowed as well as "/search.json"
  def force_json
    request.format = :json
  end
end

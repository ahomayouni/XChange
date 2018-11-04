class HomeController < ApplicationController
  before_action :force_json, only: :autocomplete
  
  def index
  end
    
  def search
      @listings_found = Listing.ransack(title_cont: params[:q]).result(distinct: true)
      @users_found = User.ransack(name_cont: params[:q]).result(distinct: true)

  end
    
  def autocomplete
    @listings_found = Listing.ransack(title_cont: params[:q]).result(distinct: true)
    @users_found = User.ransack(name_cont: params[:q]).result(distinct: true)
    
      respond_to do |format|
      format.html{}
      format.json{
        @listings_found = @listings_found.limit(5)
        @users_found = @users_found.limit(5)
      }
    end
  end
  private 

  #to ensure "/search" is allowed as well as "/search.json"
  def force_json
    request.format = :json
  end

end

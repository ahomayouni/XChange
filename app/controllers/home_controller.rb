class HomeController < ApplicationController
  before_action :force_json, only: [:autocomplete_users, :autocomplete_listings]
  
  def index
  end
    
  def search_users
      @users_found = User.ransack(name_cont: params[:users_q]).result(distinct: true)
  end
  
  def search_listings
    @listings_found = Listing.ransack(title_cont: params[:listings_q]).result(distinct: true)
  end
    
  def autocomplete_users
    @users_found = User.ransack(name_cont: params[:users_q]).result(distinct: true)

      respond_to do |format|
      format.html{}
      format.json{
        @users_found = @users_found.limit(5)
      }
    end
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
  private 

  #to ensure "/search" is allowed as well as "/search.json"
  def force_json
    request.format = :json
  end

end

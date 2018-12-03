class LiveSearchesController < ApplicationController
  before_action :set_live_search, only: [:show, :edit, :update, :destroy]

  # GET /live_searches
  # GET /live_searches.json
  def index
    @live_searches = LiveSearch.all
  end

  # GET /live_searches/1
  # GET /live_searches/1.json
  def show
  end

  # GET /live_searches/new
  def new
    #@live_search = LiveSearch.new
    @live_search = current_user.live_searches.build
  end

  # GET /live_searches/1/edit
  def edit
  end

  # POST /live_searches
  # POST /live_searches.json
  def create
    #@live_search = LiveSearch.new(user_id: current_user.id, title: params[:title], category: params[:category], from_when: params[:from_when], to_when: params[:to_when], where: params[:where])
    #@live_search = current_user.live_searches.build(user_id: current_user.id, title: params[:title], category: params[:category], from_when: params[:from_when], to_when: params[:to_when], where: params[:where])
      @live_search = current_user.live_searches.build(live_search_params)
      @live_search.user_id = current_user.id
      if Listing.where(title: @live_search.title).count != 0
        # link = "<a href=\"#{listing_path(Listing.find_by(title: @live_search.title))}\">here</a>"
        # flash[:error] = "#{link}".html_safe
        # flash[:error] = "Listing exists already #{view_context.link_to('here', listing_path(Listing.find_by(title: @live_search.title)))}".html_safe
        #flash[:error] = "Item exists already #{link_to Listing.find_by(title: @live_search.title).id, :controller => 'listing_controller', :action => 'get'}."
        flash[:error] = %Q[ Listing already exists #{view_context.link_to("here", listing_path(Listing.find_by(title: @live_search.title)))}]
      else
        respond_to do |format|
          if @live_search.save
            format.html { redirect_to action: "index" }
            format.json { render :show, status: :created, location: @live_search }
          else
            format.html { render :new }
            format.json { render json: @live_search.errors, status: :unprocessable_entity }
          end
        end
      end
  end

  # PATCH/PUT /live_searches/1
  # PATCH/PUT /live_searches/1.json
  def update
    respond_to do |format|
      if @live_search.update(live_search_params)
        format.html { redirect_to @live_search}
        format.json { render :show, status: :ok, location: @live_search }
      else
        format.html { render :edit }
        format.json { render json: @live_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_searches/1
  # DELETE /live_searches/1.json
  def destroy
    @live_search.destroy
    respond_to do |format|
      format.html { redirect_to live_searches_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_live_search
      @live_search = LiveSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def live_search_params
      params.require(:live_search).permit(:title, :category, :from_when, :to_when, :where)
    end
end

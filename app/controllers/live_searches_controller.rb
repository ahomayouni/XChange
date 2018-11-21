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
    @live_search = LiveSearch.new
  end

  # GET /live_searches/1/edit
  def edit
  end

  # POST /live_searches
  # POST /live_searches.json
  def create
    @live_search = LiveSearch.new(user_id: current_user.id, title: params[:titile], category: params[:category], from_when: params[:from_when], to_when: params[:to_when], where: params[:where])

    respond_to do |format|
      if @live_search.save
        format.html { redirect_to @live_search, notice: 'Live search was successfully created.' }
        format.json { render :show, status: :created, location: @live_search }
      else
        format.html { render :new }
        format.json { render json: @live_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /live_searches/1
  # PATCH/PUT /live_searches/1.json
  def update
    respond_to do |format|
      if @live_search.update(live_search_params)
        format.html { redirect_to @live_search, notice: 'Live search was successfully updated.' }
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
      format.html { redirect_to live_searches_url, notice: 'Live search was successfully destroyed.' }
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
      params.require(:live_search).permit(:user_id, :title, :category, :from_when, :to_when, :where)
    end
end

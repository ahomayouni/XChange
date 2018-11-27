class ChatroomsController < ApplicationController

  def new
    @chatroom = Chatroom.new
  end

  def create
    @borrow_request = BorrowRequest.find(borrow_request_id)
    @chatroom = Chatroom new chatroom_params
    
    if @chatroom.save
      @listing = Listing.find(@borrow_request.listing_id)
      @chatroom.title = @listing.title + ' Discussion'
    end
    
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = Message.where(chatroom_id: params[:id])
  end

  private
  def chatroom_params
    params.require(:chatroom).permit(:borrow_request_id)
  end

end
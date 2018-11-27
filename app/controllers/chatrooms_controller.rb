class ChatroomsController < ApplicationController

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new chatroom_params
    @borrow_request = BorrowRequest.find(borrow_request_id)
    @listing = Listing.find(@borrow_request.listing_id)
    @chatroom.title = @listing.title + ' Discussion'
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = Message.where(chatroom_id: params[:id])
  end

  private
  def chatroom_params
    #don't need title as title can be set optionally by user
    params.require(:chatroom).permit(:title, :user_ids => [])
  end

end
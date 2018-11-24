class ChatroomsController < ApplicationController
  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new chatroom_params
    
  end
    

  private
  def chatroom_params
    #don't need title as title can be set optionally by user
    params.require(:chatroom).permit(:title)
  end

end
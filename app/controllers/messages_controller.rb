class MessagesController < ApplicationController
    def new
      @message = Message.new
    end

    def create
      @message = Message.new message_params
      @message.chatroom_id = params[:chatroom_id]
      @borrower_id = params[:borrower_id]
      if @message.chatroom_id == nil
        @borrower = User.find(@borrower_id)
        # when there is an ongoing conversation already
        if current_user.messages.find_by(borrower_id: @borrower_id) != nil
          #redirect_back fallback_location: request.referrer # put location of messages here
          @message.errors.add(:chatroom, "between both parties is already exists. Please go to it in your messages page.")
        end
        @message.borrower_id = params[:borrower_id]
        # update so we know there is a conversation going on
      end
      @chatroom = Chatroom.create
      @chatroom.update_attribute(:user_ids, [current_user.id, @message.borrower_id])
      @message.chatroom_id = @chatroom.id
      @message.user_id = current_user.id

      if @message.save
        ActionCable.server.broadcast 'messages',
          message: @message.content,
          user: @message.user.name
          redirect_to chatroom_path(@message.chatroom_id)
        #redirect_back fallback_location: request.referrer
      else 
        redirect_back fallback_location: request.referrer, notice: @message.errors.full_messages[0]
      end
    end
  
    private
    def message_params
      params.require(:message).permit(:content, :chatroom_id, :borrower_id)
    end
end
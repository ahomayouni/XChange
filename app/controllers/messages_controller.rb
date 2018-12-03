class MessagesController < ApplicationController
    def new
      @message = Message.new
    end

    def create
      @message = Message.new message_params
      @message.chatroom_id = params[:chatroom_id]
      @borrower_id = params[:borrower_id]
      @message.user_id = current_user.id

      if @message.save
        ActionCable.server.broadcast 'messages',
          message: @message.content,
          user: @message.user.name
          redirect_back fallback_location: request.referrer
          respond_to do |format|
            format.js 
          end
        
      else 
        flash[:danger] = @message.errors.full_messages[0]
        redirect_back fallback_location: request.referrer 
      end
    end
  
    private
    def message_params
      params.require(:message).permit(:content, :chatroom_id, :borrower_id)
    end
end
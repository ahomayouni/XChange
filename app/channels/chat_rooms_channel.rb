class ChatRoomsChannel < ApplicationCable::Channel
    identified_by :current_user

    def connect
        self.current_user = find_verified_user
        logger.add_tags 'ActionCable', current_user.email
    end
    
    def subscribed
      stream_from "chat_rooms_#{params['chat_room_id']}_channel"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
    def send_message(data)
        current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
    end
  end
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      # logs for debugging
      logger.add_tags 'ActionCable', current_user.email
    end

    
  end
end
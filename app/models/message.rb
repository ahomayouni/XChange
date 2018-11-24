class Message < ApplicationRecord
    attr_accessor
    belongs_to :chatroom
    belongs_to :user

    validate :finding_method
    validate :no_self_messaging


    def finding_method
        if chatroom_id == nil && borrower_id == nil
            errors.add(:chatroom_id, "is not filled, this is an internal error. Please refresh or go back to the previous web page.")
        end
    end

    def no_self_messaging
        if borrower_id != nil
            if user_id == borrower_id
                errors.add(:chatroom, "are not allowed to be created with your self")
            end
        end
    end


end

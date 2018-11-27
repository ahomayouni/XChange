class Comment < ApplicationRecord
    # one comment can have many comments reply to it or reply to anything
    attr_accessor
    belongs_to :reply, polymorphic: true
    has_many :comments, as: :reply
    
    validates :body, length: {minimum: 1}
    validate :validate_rating
    validate :has_rating
    validate :has_borrowed

    def validate_rating
        unless rating.blank? 
            if rating > 5 || rating < 0
                errors.add(:rating, "needs to be from 0-5")
            end
        end
    end

    def has_rating
        if rating.blank? && reply_type == "Listing"
            errors.add(:reply, "needs to have a rating")
        end
    end
                
    def has_borrowed
        # we we are replying to a person and the commenter has on borrow request
        # if reply_type == "Person"
        #     user_borrowed = false
        #     for BorrowRequest.where(user_id: user_id, status: :approved).each do |request|
        #         owner_id = Listing.find(request.listing_id).user_id
        #         if owner_id == reply_id
        #             user_borrowed = true
        #         end
        #     end
        #     if !user_borrowed
        #         errors.add(:reply, "must have something borrowed from them")
        #     end
        # end
    end  
end

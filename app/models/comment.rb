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
        user_borrowed = false
        # make it so that any comment can reply to anything
        if reply_type == "Comment"
            user_borrowed = true
        end
        #finds all of the users borrow requests made on the replying listing
        puts "PRINTING COMMENTER_ID"
        puts commenter_id
        BorrowRequest.where(user_id: commenter_id).each do |request|
            if request.status == "borrowed" || request.status == "returned"
                # find out who's listing it is
                listing = Listing.find(request.listing_id)
                # when we are reviewing the same person who's listing we might have borrowed once
                if reply_type == "Person" && listing.user_id == reply_id
                    user_borrowed = true
                end
                # when we are reviewing an item which we have borrwed in the past
                if reply_type == "Listing" && listing.id == reply_id
                    user_borrowed = true
                end
            end
        end
        Listing.where(user_id: commenter_id).each do |list|
            list.borrow_requests.each do |req|
                if req.status == "borrowed" || req.status == "returned"
                    user_borrowed = true
                end
            end
        end
                    
        if !user_borrowed
            errors.add(:reply, "must have something borrowed from poster")
        end
    end  
end

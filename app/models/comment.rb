class Comment < ApplicationRecord
    # one comment can have many comments reply to it or reply to anything
    attr_accessor
    belongs_to :reply, polymorphic: true
    has_many :comments, as: :reply
    
    validates :body, length: {minimum: 1}
    validate :validate_rating
    validate :has_rating

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
                

    

end

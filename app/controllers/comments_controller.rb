class CommentsController < ApplicationController
before_action :find_reply
#before_action :update_person
    def new
        @comment = Comment.new
    end

    def create
        ## changes to >rails 4 code i.e https://stackoverflow.com/questions/24478246/rails-form-is-not-saving-input-to-the-database
        #start user with current id
        @comment = @reply.comments.new comment_params
        @comment.commenter_id = current_user.id
        @comment.subject_id = @reply.id # remove subject id and replace with reply_id
        
        if @comment.save
            #when users reply to a person
            if @comment.reply_type == "Person"
                @person = Person.find(@comment.subject_id)
                if @person.rating != nil
                    old_review = @person.rating
                    total_reviews = Comment.where(subject_id: @comment.subject_id, reply_type: "Person").length
                    old_review *= total_reviews
                    old_review += @comment.rating
                    old_review /= total_reviews
                    @person.update_attribute(:rating, old_review)
                else
                    @person.update_attribute(:rating, @comment.rating) 
                end
            end
            #when you comment on listings
            if @comment.reply_type == "Listing"
                @listing = Listing.find(@comment.subject_id)
                if @listing.rating
                    old_review = @listing.rating
                    total_reviews = Comment.where(subject_id: @comment.subject_id, reply_type: "Listing").length
                    old_review *= (total_reviews-1)
                    if not @comment.rating.nil?
                        old_review += @comment.rating
                    else
                        old_review += 0
                    end
                    old_review /= total_reviews
                    @listing.update_attribute(:rating, old_review)

                    # Don't give myself a notification.
                    @notif_recipient = User.find(@listing.user_id)
                    if not @notif_recipient.id == current_user.id 
                        @new_notif = Notification.new(recipient: @notif_recipient, actor_id: current_user.id ,action: "new_listing_comment",notifiable: @listing)
                        @new_notif.save
                    end 
                else
                    @listing.update_attribute(:rating, @comment.rating)
                end
            end
        #redirect_to :back, notice: 'Your review was successfully posted!'
        redirect_back fallback_location: request.referrer, notice: 'Your review was successfully posted!'
        else
        #format.html { redirect_to :back, notice: 'Building Created!' }
        #redirect_to , notice: "Your review wasn't posted!"
        redirect_back(fallback_location: listings_path, notice: "Your review wasn't posted!, Make sure to write something down")
        end
    end
    
    #methods to handle parent comments
    private
    
    def comment_params
        params.require(:comment).permit(:body, :rating)
    end
    
    #finds the parent comment if any
    def find_reply
        @reply = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
        #@reply = Subject.find_by_id(params[:subject_id]) if params[:subject_id]
        @reply = Person.find_by_id(params[:person_id]) if params[:person_id]
        @reply = Listing.find_by_id(params[:listing_id]) if params[:listing_id]
    end

    def update_person
        @person = Person.find_by_id(params[:commenter_id]) if params[:commenter_id]
    end
    
end
    
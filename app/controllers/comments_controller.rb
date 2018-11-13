class CommentsController < ApplicationController
before_action :find_reply
#before_action :update_person
    def new
        @comment = Comment.new
    end
    
    def edit
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
                    old_review /= total_reviews+1
                    @person.update_attribute(:rating, old_review)
                else
                    @person.update_attribute(:rating, @comment.rating) #not working ?
                end
            end
            #when you comment on listings
            if @comment.reply_type == "Listing"
                @listing = Listing.find(@comment.subject_id)
                if @listing.rating
                    old_review = @listing.rating
                    total_reviews = Comment.where(subject_id: @comment.subject_id, reply_type: "Listing").length
                    old_review *= total_reviews
                    old_review += rating
                    old_review /= total_reviews+1
                    @listing.update_attribute(:rating, old_review)
                else
                    @listing.update_attribute(:rating, @comment.rating)
                end
            end
        #redirect_to :back, notice: 'Your review was successfully posted!'
        redirect_back fallback_location: request.referrer, notice: 'Your review was successfully posted!'
        else
        redirect_to :back, notice: "Your review wasn't posted!"
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
    
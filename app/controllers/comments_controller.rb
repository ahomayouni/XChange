class CommentsController < ApplicationController
before_action :find_reply
#before_action :update_person
    def new
        @comment = Comment.new
    end
    
    def edit
    end

    def create
        @comment = @reply.comments.new comment_params
        @comment.commenter_id = current_user.id
        
        # temp message to ensure review save correctly
        if @comment.save
            if @comment.reply_type == "Person"
                @person = Person.find(@comment.subject_id)
                if @person.review
                    old_review = @person.review
                    total_reviews = Comment.where(subject_id: @comment.comment_id, reply_type: "Person").length
                    old_review *= total_reviews
                    old_review += rating
                    old_review /= total_reviews+1
                    @person.write_attribute(:review, old_review)
                else
                    @person.write_attribute(:review, @person.review)
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
        params.require(:comment).permit(:body)
    end
    
    #finds the parent comment if any
    def find_reply
        @reply = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
        #@reply = Subject.find_by_id(params[:subject_id]) if params[:subject_id]
        @reply = Person.find_by_id(params[:person_id]) if params[:person_id]
    end

    def update_person
        @person = Person.find_by_id(params[:commenter_id]) if params[:commenter_id]
    end
    
end
    
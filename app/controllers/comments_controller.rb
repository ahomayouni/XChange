class CommentsController < ApplicationController
    before_action :find_reply
    
        def new
          @comment = Comment.new
        end
        
        def create
          @comment = @reply.comments.new comment_params
            
          # temp message to ensure review save correctly
          if @comment.save
            redirect_to :back, notice: 'Your review was successfully posted!'
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
          @reply = Subject.find_by_id(params[:subject_id]) if params[:subject_id]
        end
    
    end
    
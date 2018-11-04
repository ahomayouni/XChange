## genarate from rails if needed
class SubjectsController < ApplicationController

    #basic shows initial layout of subject
      def index
        @subjects = Subject.all
      end
    
      def show
        @subject = Subject.find(params[:id])
      end
end
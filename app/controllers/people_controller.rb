## genarate from rails if needed
class PeopleController < ApplicationController

    #basic shows initial layout of subject
      def index
        @people = Person.all
      end
    
      def show
        @person = Person.find(params[:id])
      end
end
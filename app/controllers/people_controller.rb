## genarate from rails if needed
class PeopleController < ApplicationController
  before_action :find_person
  before_action :find_review
    #basic shows initial layout of subject
      def index
        @people = Person.all
      end
      
      def update
        @reviews
      end

      def show
        @person
      end 

      private

      def find_person
        @person = Person.find(params[:id])
      end

      def find_review
        @reviews = Comment.where(id: @person.id)
      end

      

end
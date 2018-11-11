## genarate from rails if needed
class PeopleController < ApplicationController
  attr_accessor
  before_action :find_review
    #basic shows initial layout of subject
      def index
        @people = Person.all
      end
      
      def update
        @reviews
      end

      def show
        @person = Person.find(params[:id])
      end 

      private

      def find_review
        #@reviews = Comment.where(id: @person.id)
      end

      

end
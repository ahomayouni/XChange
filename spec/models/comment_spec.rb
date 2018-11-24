require 'rails_helper'

RSpec.describe Comment, type: :model do

  # Prerequisuites
  before(:each) do
  			@user = User.new(name:  "dodo",
							 email: "dragonball@gmail.com",
				             password:              "satuikanasin",
				             password_confirmation: "satuikanasin",
				             activated: true,
				             activated_at: Time.zone.now,
				             person: Person.create(
				              address: Faker::Address.street_address,
				              phone_number: '6471678732',
				              description: 'I am a bot created by the master Peter Tanugraha'
				             ))

  			@user.save

  			@listing = Listing.new
	  		@listing.title = "Macbook Pro"
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.category = "Film & Photography"
	  		@listing.start_lending = Date.today
	  		@listing.end_lending = Date.today + 2
	  		@listing.user_id = @user.id
	  		@listing.address = "1442 Lawrence Ave W Toronto ON"

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
  	end

  	context "Comments Validation on replying to a listing" do 
  		it "Should create a comment when the correct params are given" do 
  			@comment = Comment.new 
  			@comment.body = "This is a great item"
  			@comment.rating = 3
  			@comment.reply_type = "Listing"
  			@comment.reply_id = @listing.id 
  			@comment.save 
  			expect(Comment.all.count).to eq(1)
  		end

  		it "Should NOT create a comment when NO BODY is given" do 
  			@comment = Comment.new 
  			@comment.rating = 3 
  			@comment.reply_type = "Listing" 
  			@comment.reply_id = @listing.id 
  			@comment.save 
  			expect(Comment.all.count).to eq(0)
  		end

  		it "Should NOT create a comment when NO RATINGS are given when the selected is a listing" do 
  			@comment = Comment.new 
  			@comment.body = "This is a great item"
  			@comment.reply_type = "Listing"
  			@comment.reply_id = @listing.id 
  			@comment.save 
  			expect(Comment.all.count).to eq(0)
  		end
  	end


  	context "Comments Validation on replying to a comment" do
  		before do 
  			@comment1 = Comment.new 
  			@comment1.body = "This is a great item"
  			@comment1.rating = 3
  			@comment1.reply_type = "Listing"
  			@comment1.reply_id = @listing.id 
  			@comment1.save 
  		end
  		it "Should create a comment when the correct params are given" do 
  			@comment = Comment.new 
  			@comment.body = "Thank you for the reply!"
  			@comment.reply_type = "Comment"
  			@comment.reply_id = @comment1.id 
  			@comment.save 
  			expect(Comment.all.count).to eq(2)
  		end
  	end

  	context "Comments Validation on replying to a person" do
  		it "Should create a comment when the correct params are given" do 
  			@comment = Comment.new 
  			@comment.body = "I like your profile"
  			@comment.reply_type = "Person"
  			@comment.reply_id = @user.id
  			@comment.save 
  			expect(Comment.all.count).to eq(1)
  		end
  	end
end

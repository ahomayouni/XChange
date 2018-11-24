require 'rails_helper'

RSpec.describe Listing, type: :model do
  context "Validation tests" do 
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
  		end

	  	it "Should create a listing when all valid parameters are given" do
	  		
	  		@listing = Listing.new
	  		@listing.title = "Macbook Pro"
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.category = "Film & Photography"
	  		@listing.start_lending = "2018-11-11 00:00:00"
	  		@listing.end_lending = "2018-11-11 00:00:00"
	  		@listing.user_id = @user.id
	  		@listing.address = "1442 Lawrence Ave W Toronto ON"

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
	  		expect(Listing.all.count).to eq(1)
	  	end

	  	it "Should not create when the end date is before the starting date" do

	  		@listing = Listing.new
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.category = "Film & Photography"
	  		@listing.start_lending = "2018-11-11 00:00:00"
	  		@listing.end_lending = "2018-09-11 00:00:00"
	  		@listing.user_id = @user.id
	  		@listing.address = "1442 Lawrence Ave W Toronto ON"

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
	  		expect(Listing.all.count).to eq(0)
	  	end

	  	it "Should not create when there is no title" do
	  		
	  		@listing = Listing.new
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.category = "Film & Photography"
	  		@listing.start_lending = "2018-11-11 00:00:00"
	  		@listing.end_lending = "2018-11-11 00:00:00"
	  		@listing.user_id = @user.id
	  		@listing.address = "1442 Lawrence Ave W Toronto ON"

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
	  		expect(Listing.all.count).to eq(0)
	  	end

	  	it "Should not create when there is no address" do
	  		
	  		@listing = Listing.new
	  		@listing.title = "Macbook Pro"
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.category = "Film & Photography"
	  		@listing.start_lending = "2018-11-11 00:00:00"
	  		@listing.end_lending = "2018-11-11 00:00:00"
	  		@listing.user_id = @user.id

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
	  		expect(Listing.all.count).to eq(0)
	  	end

	  	it "Should not create when there is no category" do
	  		
	  		@listing = Listing.new
	  		@listing.title = "Macbook Pro"
	  		@listing.description = "Brand new macbook pro for rent :) helping out the world"
	  		@listing.start_lending = "2018-11-11 00:00:00"
	  		@listing.end_lending = "2018-11-11 00:00:00"
	  		@listing.user_id = @user.id
	  		@listing.address = "1442 Lawrence Ave W Toronto ON"

	  		   @listing.images.attach(
				   io: File.open(File.join(Rails.root, "/app/assets/images/books.jpg")),
				   filename: 'books.jpg',
				   content_type: 'image/jpeg',
				)

	  		@listing.save
	  		expect(Listing.all.count).to eq(0)
	  	end
  end
end

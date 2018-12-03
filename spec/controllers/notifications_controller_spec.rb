require 'rails_helper'
require './spec/support/spec_test_helper'

RSpec.configure do |c|
  c.include SpecTestHelper
end

def geo_code(address) 
  results = Geocoder.search(address)
  lat = nil
  lon = nil
  if results.first
    lat = "#{results.first.coordinates[0]}"
    lon = "#{results.first.coordinates[1]}"
  end
  return [lat,lon]
end

def seed_listing(title, description, category, userid, image_name, image_type, address)
  listing = Listing.new
  listing.title = title
  listing.description = description
  listing.category = category
  listing.start_lending = Faker::Date.forward(1)
  listing.end_lending = Faker::Date.forward(365)
  listing.user_id = userid
  listing.images.attach(
      io: File.open(File.join(Rails.root, ("/app/assets/images/"+image_name))),
      filename: image_name,
      content_type: image_type,
  )
  listing.address = address
  lat_long = geo_code(listing.address)
  listing.latitude = lat_long[0]
  listing.longitude = lat_long[1]
  if listing.save
    puts "Successfully created Listing id: #{listing.id} with user_id: #{listing.user_id}"
  else
  	puts "UH OH ERRORR"
    listing.errors.full_messages.each do |message|
    puts message
    end
  end
end


RSpec.describe NotificationsController, type: :controller do
	context 'GET #index' do
		it 'must not be able to index notification when user is not logged in ' do
			get :index
			expect(response).to_not be_successful
		end

		it 'must be able to index notification when user is logged in' do 
			user = User.create!(name:  "dodo",
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
			user.save
			login(user)
			Notification.create(recipient: user,actor: user,action:"created_new_account",notifiable:user)
			expect(Notification.all.count).to eq(1)
			get :index
			expect(response).to be_successful
		end

		it 'must be able to filter out "bad notifications" which is the notifiable item does not exist anymore' do 
			user = User.create!(name:  "dodo",
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
			user.save
			login(user)

			seed_listing("Saw for carpenting", "Traditional style saw", "Home / Office / Garden", user.id, 'saw.jpg', 'image/jpeg', "1710 Bayview Ave Toronto ON")
			expect(Listing.all.count).to eq(1)

			@start_borrowing = DateTime.now 
			@end_borrowing = DateTime.now + 1
			@new_request = BorrowRequest.new(listing_id: Listing.first.id, user_id: user.id, status: "approved", start_borrowing: @start_borrowing, end_borrowing: @end_borrowing)
			@new_request.save
			expect(BorrowRequest.all.count).to eq(1)

			@new_notif = Notification.new(recipient: user, actor_id: user.id ,action: "testing_scheme",notifiable: @new_request)
		    @new_notif.save

		    # Call index and should still have all of the notification
			get :index
			expect(response).to be_successful
			expect(Notification.all.count).to eq(1)

			# Simulate destroying the notifiable object here
			BorrowRequest.first.destroy 
			expect(BorrowRequest.all.count).to eq(0)

			# Expect when called the controller is called next to clean out the nil notifiable which is 
			# BorrowRequest since its already deleted
			get :index
			expect(response).to be_successful
			expect(Notification.all.count).to eq(0)
		end
	end

	context 'POST #mark_as_read' do 
		it 'must not be able to mark as read when user is not logged in ' do 
			post :mark_as_read
			expect(response).to_not be_successful
		end

		it 'must be able to mark as read when user is logged in ' do 
			user = User.create!(name:  "dodo",
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
			login(user)
			post :mark_as_read
			expect(response).to be_successful

		end
	end
end

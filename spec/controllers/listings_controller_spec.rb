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

RSpec.describe ListingsController, type: :controller do
	describe 'GET #index' do 
		context 'GET #index without logged in' do
			it 'must not be able to index groups when user is not logged in ' do
				get :index
				expect(response).to_not be_successful
			end
		end

		context 'GET #index with logged in user' do
			before(:each) do 
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
			end
			it 'must be able to index groups when user is logged in ' do
				get :index
				expect(response).to be_successful
			end
		end
	end

	describe 'GET #new' do 
		context 'GET #new without logged in' do
			it 'must not be able to index groups when user is not logged in ' do
				get :new
				expect(response).to_not be_successful
			end
		end

		context 'GET #new with logged in user' do
			before(:each) do 
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
			end
			it 'must be able to get a template for the creation of a new group when logged in ' do
				get :new
				expect(response).to be_successful
			end
		end
	end

	describe 'POST #create' do 
		context 'POST #create without logged in' do 
			it 'must not allow to create group when a user is not logged in ' do 
				post :create 
				expect(response).to_not be_successful
			end
		end

		context 'POST #create when logged in' do 
			before(:each) do 
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
			end

			it 'Must not allow to create groups when images are missing or invalid params' do
				lat_long = geo_code('262 Rhodes Ave Toronto')

				params_obj = {title:'Canon FX Camera',description:'35 mm SLR Camera',category:'Film & Photography',
					start_lending: Faker::Date.forward(1) , end_lending: Faker::Date.forward(365),user_id:User.first.id, 
					address:"262 Rhodes Ave Toronto",latitude:lat_long[0],longitude:lat_long[1]}
				post :create,params: {listing:params_obj}
				expect(Listing.all.count).to eq(0)
			end
		end
	end

end

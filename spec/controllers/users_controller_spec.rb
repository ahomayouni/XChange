require 'rails_helper'
require './spec/support/spec_test_helper'


RSpec.configure do |c|
  c.include SpecTestHelper
end


RSpec.describe UsersController, type: :controller do
	context 'GET #index' do 
		it 'returns a failed response since no user is logged in' do
			get :index
			expect(response).to_not be_successful
		end
	end

	context 'GET #edit' do 
		it 'returns a failed response since no user is logged in' do
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
			get :edit, params: {id:user.to_param}
			expect(response).to_not be_successful
		end

		it 'returns successfull response when a user is logged in' do
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
			get :edit, params: {id:user.to_param}
			expect(response).to be_successful
		end
	end

	context 'GET #update' do 
		it 'returns a failed response since no user is logged in' do
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
			get :update, params: {id:user.to_param}
			expect(response).to_not be_successful
		end
	end



end

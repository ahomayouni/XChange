require 'rails_helper'
require './spec/support/spec_test_helper'

RSpec.configure do |c|
  c.include SpecTestHelper
end

RSpec.describe NotificationsController, type: :controller do
	context 'GET #index' do
		it 'must not be able to index notification when user is not logged in ' do
			get :index
			expect(response).to_not be_successful
		end

		# Why is this returning an error?
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

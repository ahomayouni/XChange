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

	context 'PUT #update' do 
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

		it 'Should be redirected successfully to the users settings page when update is succesfull' do
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
			put :update, params: { id:user.to_param,password:'123456',
									password_confirmation:'123456',
									user:{name:'dada',address:'dada',
									phone_number:'dada',
									description:'dada'}}
			expect(response).to redirect_to(user_settings_path(user))
		end

		context "POST #create" do
			it 'Should be able to create a user successfully when not logged in' do 
				post :create, params: {user:{ name:  "dodo",
							 email: "dragonball@gmail.com",
				             password:              "satuikanasin",
				             password_confirmation: "satuikanasin"}
				         }
				expect(response).to redirect_to(root_path)    
			end

			it 'Should not be able to create a user successfully when password do not match' do 
				post :create, params: {user:{ name:  "dodo",
							 email: "dragonball@gmail.com",
				             password:              "111111",
				             password_confirmation: "satuikanasin"}
				         }
				expect(response).to render_template(:new)    
			end

			it 'Should not be able to create a user successfully when invalid email is given' do 
				post :create, params: {user:{ name:  "dodo",
							 email: "thebrownfoxjumpoverthehill",
				             password:              "111111",
				             password_confirmation: "satuikanasin"}
				         }
				expect(response).to render_template(:new)    
			end

			it 'Should not be able to create a user successfully when no name is given' do 
				post :create, params: {user:{
							 email: "thebrownfoxjumpoverthehill",
				             password:              "111111",
				             password_confirmation: "satuikanasin"}
				         }
				expect(response).to render_template(:new)    
			end
		end


	end



end

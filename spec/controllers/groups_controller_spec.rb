require 'rails_helper'
require './spec/support/spec_test_helper'

RSpec.configure do |c|
  c.include SpecTestHelper
end

RSpec.describe GroupsController, type: :controller do

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
				get :index
				expect(response).to be_successful
			end
		end
	end

	describe 'POST #show' do 
		context "POST #show without logged in" do
			it "Must not be able to show when user is not logged in " do 
				post :show, params: {id:1}
				expect(response).to_not be_successful
			end
		end

		context "POST #show when logged in" do
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

				@group = Group.new 
		  		@group.name = "People of North York"
		  		@group.description = "People living in the north york area looking to borrow and lend stuff"
		  		@group.isPublic = true 
		  		@group.save
			end
			it " Successfull response when logged in" do 
				post :show, params: {id:1}
				expect(response).to be_successful
			end
		end
	end


	describe 'POST #create' do 
		context "POST #create when not logged in" do 
			it 'MUST not be able to send a request when a user is not logged in' do 
				post :create
				expect(response).to_not be_successful
			end
		end

		context "POST #create when a user is logged in" do 
			before(:each) do 
				@user = User.create!(name:  "dodo",
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
				login(@user)
			end

			it "will be redirected to the new group page if valid params are given" do 
				post :create, params: {group:{ name:  "People of North York",
							 description: "People living in the north york area looking to borrow and lend stuff",
				             isPublic: true,
				             owner_id: @user.id}
				         }

				expect(Group.all.count).to eq(1)
				@group = Group.first 
				expect(response).to redirect_to(group_path(@group))
			end

			it "will be render new when INVALID params are given" do 
				post :create, params: {group:{ name:  "People of North York",
				             isPublic: true,
				             owner_id: @user.id}
				         }

				expect(Group.all.count).to eq(0) 
				expect(response).to render_template('new')
			end
		end
	end


	describe "DESTROY #destroy" do 
		context "#destroy when not logged in" do 
				it "should not be able to trigger destroy commands when not logged in " do 
				delete :destroy, params:{id:1}
				expect(response).to_not be_successful
			end
		end

		context "#destroy when logged in" do 
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

				@group = Group.new 
		  		@group.name = "People of North York"
		  		@group.description = "People living in the north york area looking to borrow and lend stuff"
		  		@group.isPublic = true 
		  		@group.save
			end

			it "should be able to destroy groups when correct params are given" do 
				delete :destroy, params:{id:1}
				expect(flash[:success]).to be_present
				expect(Group.all.count).to eq(0)
				expect(response).to redirect_to(groups_path)
			end

			it "should return a flash message when group trying to be deleted does not exist" do 
				delete :destroy, params:{id:100} #This id will never exist
				expect(flash[:danger]).to be_present
				expect(response).to redirect_to(groups_path)
			end
 		end
	end
end

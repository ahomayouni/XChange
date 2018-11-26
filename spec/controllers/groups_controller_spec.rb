require 'rails_helper'
require './spec/support/spec_test_helper'

RSpec.configure do |c|
  c.include SpecTestHelper
end

RSpec.describe GroupsController, type: :controller do


	describe 'GET #index' do 
		context 'GET #index without logged in' do
			it 'must not be able to index notification when user is not logged in ' do
				get :index
				expect(response).to_not be_successful
			end
		end

		context 'GET #index with logged in user' do
			it 'must be able to index notification when user is logged in ' do
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

				get :index
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
				puts @group.name
				expect(response).to redirect_to(group_path(@group))
				# expect(response).to redirect_to(root_path)
				# expect(response).to be_successful
			end

			it "will be render new when INVALID params are given" do 
				# To be done
			end
		end
	end
end

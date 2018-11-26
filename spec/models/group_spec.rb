require 'rails_helper'

RSpec.describe Group, type: :model do
  context "Model Validation Tests" do
  	it "should create a group successfully when all the valid parameters are given" do 
  		@group = Group.new 
  		@group.name = "People of North York"
  		@group.description = "People living in the north york area looking to borrow and lend stuff"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(1)
  	end

  	it "should NOT create a group when name is missing" do 
  		@group = Group.new 
  		@group.description = "People living in the north york area looking to borrow and lend stuff"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(0)
  	end

  	it "should NOT create a group when name characters is less than 5" do 
  		@group = Group.new 
  		@group.name = "a"
  		@group.description = "People living in the north york area looking to borrow and lend stuff"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(0)
  	end

  	it "should NOT create a group when description is missing" do 
  		@group = Group.new 
  		@group.name = "People of North York"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(0)
  	end

  	it "should NOT create a group when description characters is less than 5" do 
  		@group = Group.new 
  		@group.name = "People of North York"
  		@group.description = "1"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(0)
  	end

  	it "should NOT create a group when isPublic parameter is missing" do 
  		@group = Group.new 
  		@group.name = "People of North York"
  		@group.description = "People living in the north york area looking to borrow and lend stuff"
  		@group.save

  		expect(Group.all.count).to eq(0)
  	end
  end

  context "Associations testing with User Model" do
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

  	it "A user model should be able to create a new group for him/her" do
  		@user.groups.create(name:"People of North York", description:"People living in the north york area looking to borrow and lend stuff",
  							isPublic: true)

  		expect(@user.groups.count).to eq(1)
  		expect(Group.all.count).to eq(1)
  	end
  end
end

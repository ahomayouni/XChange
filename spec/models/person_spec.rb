require 'rails_helper'

RSpec.describe Notification, type: :model do
  context "validation tests" do 
  	it 'Must be able to access the person information on the user' do
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
	  	@person_obj = @user.person 
	  	expect(@person_obj.nil?).to eq(false)
  	end


  	it 'Must be able to update the person information' do
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
	  	@person_obj = @user.person 
	  	@person_obj.phone_number = '1111111111'
	  	@person_obj.save

	  	# Refresh the user model we are working with from the database
	  	@user = User.find(@user.id)
	  	@new_person_obj = @user.person

	  	expect(@new_person_obj.phone_number).to eq('1111111111')
  	end
  end

  context 'dependency tests' do 
  	it 'when a user is destroyed the person info associated must also be destroyed ' do
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
	  	@user.destroy 
	  	expect(Person.all.count).to eq(0)
	  end
  	end
end

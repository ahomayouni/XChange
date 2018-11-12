require 'rails_helper'

RSpec.describe Notification, type: :model do
  context "scope tests" do 
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
  end
end

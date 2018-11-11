require 'rails_helper'

RSpec.describe User, type: :model do
	context 'validation tests' do 
		it 'ensures email is presence' do
			@user = User.new(name:  "dodo",
				             password:              "dodo",
				             password_confirmation: "dodo",
				             activated: true,
				             activated_at: Time.zone.now,
				             person: Person.create(
				              address: Faker::Address.street_address,
				              phone_number: '6471678732',
				              description: 'I am a bot created by the master Peter Tanugraha'
				             ))
			user_save_success = @user.save
			expect(user_save_success).to eq(false)
		end
	end

	context 'scope tests' do
	end
end

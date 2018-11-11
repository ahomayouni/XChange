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

		it 'ensures name is presence' do
			@user = User.new(email: "dragonball@gmail.com",
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

		it 'ensures password matches' do
			@user = User.new(name:  "dodo",
							 email: "dragonball@gmail.com",
				             password:              "password1",
				             password_confirmation: "password2",
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

		it 'ensures password has at least 5 different characters although they match' do
			@user = User.new(name:  "dodo",
							 email: "dragonball@gmail.com",
				             password:              "1",
				             password_confirmation: "1",
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

		it 'ensures user saves correctly, when valid data is present' do
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
			user_save_success = @user.save
			expect(user_save_success).to eq(true)
		end
	end

	context 'scope tests' do
	end
end

require 'rails_helper'

RSpec.describe User, type: :model do
	context 'validation tests' do 
		it 'ensures email field is present' do
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

		it 'ensures name field is presenct' do
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

		it 'ensures email address with valid regex' do
			@user = User.new(name:  "dodo",
							 email: "this is not an email",
				             password:              "1111111",
				             password_confirmation: "1111111",
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
		it 'ensures that a person model is also created alongside with the creation of a user model' do
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
			expect(@user.person.nil?).to eq(false)
		end
	end
end

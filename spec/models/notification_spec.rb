require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'validation tests' do 
	  	it 'simply creating a notification' do 
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


		  	@user_2 = User.new(name:  "dodo",
								email: "dragonball_2@gmail.com",
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
		  	@user_2.save
		  	Notification.create(recipient: @user_2,actor: @user,action:"testing_purposes",notifiable:@user)

		  	expect(Notification.all.count).to eq(1)
	  end

	  it 'must not save when recipient or actor is empty' do 
		  	@notification = Notification.new(action:"testing_purposes",notifiable:@user)
		  	notif_results = @notification.save
		  	expect(notif_results).to eq(false)
	  end

	  it 'simply creating a notification' do 
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


		  	@user_2 = User.new(name:  "dodo",
								email: "dragonball_2@gmail.com",
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
		  	@user_2.save
		  	@notification = Notification.new(recipient: @user_2,actor: @user,notifiable:@user)
		  	notif_results = @notification.save
		  	expect(notif_results).to eq(false)
	  end
  end
end

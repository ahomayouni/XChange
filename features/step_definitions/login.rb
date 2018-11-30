Given("that I have already signed up and activated my account") do
  normal_user = User.new(name:  "valid user",
							 email: "valid_user@gmail.com",
				             password:              "111111",
				             password_confirmation: "111111",
				             activated: true,
				             activated_at: Time.zone.now,
				             person: Person.create(
				              address: Faker::Address.street_address,
				              phone_number: '6471678732',
				              description: 'I am a bot created by the master Peter Tanugraha'
				             ))
	normal_user.save
	Notification.create(recipient: normal_user,actor: normal_user,action:"created_new_account",notifiable:normal_user)
end

Then("I should see a login button") do
	expect(page).to have_content('Log In')
end

When("I click the login button") do
  click_link 'Log In'
end

Then("I should see a login modal with neccessary fields") do
  expect(page).to have_content('Email')
  expect(page).to have_content('Password')
end

When("I input my correct login credentials") do
	fill_in 'session_email', with: 'valid_user@gmail.com'
	fill_in 'session_password', with: '111111'
	click_button 'Log in'
end

Then("I should be able to login and see my dashboard") do
  expect(page).to have_content('Dashboard')
end

Then("I should be able to see notifications") do
	page.all(:css, "a[id='dropdownMenu1']").last().click()
	expect(Notification.all.count).to eq(1)
	# Element not found (?)
	# page.all(:css, "a[id='welcometoexchange']").last().click()
end
Then("I should see a borrow request button") do
  expect(page).to have_button("Request Item")
end

When("I fill in the borrow request date range with string: {string}") do |string|
  fill_in "borrow_request_date_range", with: string #This is the id of the input field. 
  click_button "Apply"
end

When("I click the borrow request button no javascript mode") do
  fill_in "borrow_request_date_range", with: "2018/11/30 - 2019/08/16" #This is the id of the input field. 
  click_button "Request Item"
end

Then("I should see a modal pop up with next steps instructions on what to do") do
  page.should have_css('div#borrowRequestSuccessModal')
end

Then("I click randomly on screen to get rid of the modal") do 
	page.find(:xpath,"//*[text()='XChange']").click
end

When("I logout") do
  click_link "accountDropDown"
  sleep(2)
  click_link "Log Out"
end

Then("I should be redirected to the home landing page") do
  expect(page).to have_content("ABOUT")
end

When("I login with email: {string} and password: {string} and my name is: {string}") do |string,string1,string2|
	expect(page).to have_content('Log In')
	click_link 'Log In'
	sleep(2)
	expect(page).to have_content('Email')
	expect(page).to have_content('Password')
	fill_in 'session_email', with: string
	fill_in 'session_password', with: string1
	click_button 'Log in'
	sleep(3)
	expect(page).to have_content('Dashboard')
	expect(page).to have_content(string2) # The owner is peter :)
end

When("I click on the notifications button") do 
	page.all(:css, "a[id='dropdownMenu1']").last().click()
end

Then("I would expect that {string} would have {string} notification in the database") do |string, string2|
	@recipient = User.find_by(name:string)
	@all_notifications = Notification.where(recipient_id:@recipient.id)
	expect(@all_notifications.count).to eq(string2.to_i)
end

When("I click the notification with id {string}") do |string|
	page.all(:css, "a[id=#{string}]").last().click()
end

Then("I will be redirected to pending approvals tab and see the listing item `saw` over there") do
  expect(page).to have_content("Pending Approvals")
end

When ("I click the {string} tab from the dashboard") do |string|
	click_link string
end

When("I click the button {string}") do |string|
  click_button string
end

When("I click the link {string}") do |string|
  click_link string
end

Then("I should see a modal on successfull of approval") do
  page.should have_css('div#approveModal') #This is not the name of the flash . 
end

Then("I click the my rentals button") do 
	click_button "My Rentals"
end
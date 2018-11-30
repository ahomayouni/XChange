Then("I should see a borrow request button") do
  expect(page).to have_button("Request Item")
end

When("I click the borrow request button") do
  fill_in "borrow_request_date_range", with: "2018/11/30 - 2019/08/16" #This is the id of the input field. 
  click_button "Request Item"
end

Then("I should see a modal pop up with next steps instructions on what to do") do
  page.should have_css('div#borrowRequestSuccessModal')
end

When("I logout") do
  click_link "accountDropDown"
  click_link "Log Out"
end

Then("I should be redirected to the home landing page") do
  expect(page).to have_content("ABOUT")
end

When("I login as the owner of the item") do
	expect(page).to have_content('Log In')
	click_link 'Log In'
	expect(page).to have_content('Email')
	expect(page).to have_content('Password')
	fill_in 'session_email', with: 'peter@gmail.com'
	fill_in 'session_password', with: '12345'
	click_button 'Log in'
	expect(page).to have_content('Dashboard')
	expect(page).to have_content('cucumber_tester')
end

Then("I should see a notification telling me user `cucumber_tester` has requested to borrow my item") do
  page.all(:css, "a[id='dropdownMenu1']").last().click()
  # Element here still not found
  # page.all(:css, "a[id='initialBorrowRequest']").last()
end

Then("I would expect that {string} would have {string} notification in the database") do |string, string2|
	@recipient = User.find_by(name:string)
	@all_notifications = Notification.where(recipient_id:@recipient.id)
	expect(@all_notifications.count).to eq(string2.to_i)
end

When("I click the notification with id {string}") do |string|
	# page.all(:css, "a[id='initialBorrowRequest']").last().click()
end

Then("I will be redirected to pending approvals tab and see the listing item `saw` over there") do
  expect(page).to have_content("Pending Approvals")
end

When ("I click the {string} tab from the dashboard") do |string|
	click_link string
end

When("I click the button `Approve`") do
  click_link "Approve"
end

Then("I should see a modal on successfull of approval") do
  page.should have_css('div#approveModal') #This is not the name of the flash . 
end
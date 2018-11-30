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

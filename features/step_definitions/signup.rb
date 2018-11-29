When("I go to the home page") do
  visit root_path
end

Then("I should see a signup button") do
	expect(page).to have_content('XChange')
end

When("I click the signup button") do
  click_link 'Sign Up'
end

Then("I should see a modal with neccessary fields") do
  expect(page).to have_content('Sign up')
  expect(page).to have_content('Name')
  expect(page).to have_content('Email')
  expect(page).to have_content('Password')
  expect(page).to have_content('Confirm Password')
end

When("I input my correct information") do
	within('#signupModal') do 
  		fill_in 'user_name', with: 'Peter Tanugraha'
  		fill_in 'user_email', with: 'p.tar@gmail.com'
  		fill_in 'user_password', with: '111111'
  		fill_in 'user_password_confirmation', with: '111111'
  		click_button 'Submit'
  	end
end

Then("I should see an account being created") do
  expect(page).to have_content('Thanks for signing up with XChange!')
end

When("I input my wrong information") do
  within('#signupModal') do 
  		fill_in 'user_name', with: 'Peter Tanugraha'
  		fill_in 'user_email', with: 'p.tar@gmail.com'
  		fill_in 'user_password', with: '111111'
  		fill_in 'user_password_confirmation', with: '123456'
  		click_button 'Submit'
  	end
end

Then("I should an error message telling me to try signup again") do
  expect(page).to have_content('The signup form was put in incorrectly')
end
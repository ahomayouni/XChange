When("I go to the home page") do
  visit root_path
end

Then("I should see a signup button") do
	expect(page).to have_link('signupHomeButton')
end

When("I click the signup button") do
  click_link 'signupHomeButton'
end

Then("I should see a modal with neccessary fields") do
  within('#signupModal') do 
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Name')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Confirm Password')
  end
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


When("I input my wrong password confirmation") do
  within('#signupModal') do 
  		fill_in 'user_name', with: 'Peter Tanugraha'
  		fill_in 'user_email', with: 'p.tar@gmail.com'
  		fill_in 'user_password', with: '111111'
  		fill_in 'user_password_confirmation', with: '123456'
  		click_button 'Submit'
  	end
end


When("I input my wrong fields with no name") do 
	within('#signupModal') do 
	  	fill_in 'user_email', with: 'p.tar@gmail.com'
	  	fill_in 'user_password', with: '111111'
	  	fill_in 'user_password_confirmation', with: '111111'
	  	click_button 'Submit'
  	end
end

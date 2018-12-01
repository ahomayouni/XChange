require 'rails_helper'

RSpec.feature "Users", type: :feature do
	context 'create new user' do 
		it 'should be successful' do 
			visit root_path
			within('#signupModal') do 
				expect(page).to have_content('Sign up')
				expect(page).to have_content('Name')
				expect(page).to have_content('Email')
				expect(page).to have_content('Password')
				expect(page).to have_content('Confirm Password')

				fill_in 'user_name', with: 'Peter Tanugraha'
				fill_in 'user_email', with: 'p.tar@gmail.com'
				fill_in 'user_password', with: '111111'
				fill_in 'user_password_confirmation', with: '111111'
				click_button 'Submit'
			end
			within('div.alert') do 
				page.should have_content('Thanks for signing up with XChange!')
			end
		end

		it 'should fail when there is a different password confirmation' do 
			visit root_path
			within('#signupModal') do 
				expect(page).to have_content('Sign up')
				expect(page).to have_content('Name')
				expect(page).to have_content('Email')
				expect(page).to have_content('Password')
				expect(page).to have_content('Confirm Password')

				fill_in 'user_name', with: 'Peter Tanugraha'
				fill_in 'user_email', with: 'p.tar@gmail.com'
				fill_in 'user_password', with: '111222'
				fill_in 'user_password_confirmation', with: '111555'
				click_button 'Submit'
			end
			within('#error_explanation') do
				expect(page).to have_content('The form contains 1 error')
			end
		end
	end


	context 'login user' do 
		before(:each) do 
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

			un_activated_user = User.new(name:  "unactivated user",
							 email: "unactivated_user@gmail.com",
				             password:              "111111",
				             password_confirmation: "111111",
				             activated: false,
				             person: Person.create(
				              address: Faker::Address.street_address,
				              phone_number: '6471678732',
				              description: 'I am a bot created by the master Peter Tanugraha'
				             ))
			un_activated_user.save
		end

		it 'should be successfull when the user is already registered in the application' do 
			visit root_path
			within('#loginModal') do 
				expect(page).to have_content('Email')
				expect(page).to have_content('Password')
				fill_in 'session_email', with: 'valid_user@gmail.com'
				fill_in 'session_password', with: '111111'
				click_button 'Log in'
			end
			within(".xchange-header") do 
				expect(page).to have_content('valid user')
			end
		end

		it 'should be not successfull when the user is not activated' do 
			visit root_path
			within('#loginModal') do 
				expect(page).to have_content('Email')
				expect(page).to have_content('Password')
				fill_in 'session_email', with: 'unactivated_user@gmail.com'
				fill_in 'session_password', with: '111111'
				click_button 'Log in'
			end
			within("div.alert") do 
				expect(page).to have_content('Account not activated')
			end
		end

		it 'should not be successfull when the user is not registered in the application' do 
			visit root_path
			within('#loginModal') do 
				expect(page).to have_content('Email')
				expect(page).to have_content('Password')
				fill_in 'session_email', with: 'capybara@gmail.com'
				fill_in 'session_password', with: '123456'
				click_button 'Log in'
			end
			within('div.alert') do
				expect(page).to have_content('Invalid email/password combination')
			end
		end
	end
end

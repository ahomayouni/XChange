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
			expect(page).to have_content('Thanks for signing up with XChange!')
		end

		it 'should fail' do 
		end
	end
end

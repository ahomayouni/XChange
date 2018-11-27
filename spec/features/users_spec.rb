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
			end
		end

		it 'should fail' do 
		end
	end
end

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "Invalid signup information" do 
  	get new_user_path
  	assert_no_difference 'User.count' do 
  		post users_path, params:{ user: {name:"",
  										email:'lalala',
  										password:'thisisa',
  										password_confirmation:'thisisb'} }
  		end
  	assert_template 'users/new'
  	end

end

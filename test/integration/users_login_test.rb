require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with empty information" do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params:{session:{email:"",password:""} }
  	assert_template 'sessions/new'
  	assert_not flash.empty? #Strain testing on the flash
  	get root_path
  	assert flash.empty? #Must be using flash.now to kill the flash after
  end

  test "login with invalid information" do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params:{session:{email:"example",password:"111111"} }
  	assert_template 'sessions/new'
  	assert_not flash.empty? 
  	get root_path
  	assert flash.empty? 
  end


end

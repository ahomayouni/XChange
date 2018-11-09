require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@main_subject = User.new(name: "Jokowi", email: "jokowi@private.com",password: '111111', password_confirmation:'111111')
  end

  test "password is not present" do
  	@test_subject = User.new(name: "Jokowi", email: "jokowi@private.com")
  	assert_not @test_subject.valid?
  end

  test "Fields are all matched up and should be valid " do
  	@test_subject = User.new(name: "Jokowi", email: "jokowi@private.com",password: '111111', password_confirmation:'111111')
  	assert @test_subject.valid?
  end

  test "name should not be empty" do
  	@test_subject = User.new(name: "  ", email: "jokowi@private.com",password: '111111', password_confirmation:'111111')
  	assert_not @test_subject.valid?
  end

  test "password should match" do
  	@test_subject = User.new(name: "  ", email: "jokowi@private.com",password: '111111', password_confirmation:'000000')
  	assert_not @test_subject.valid?
  end

  test "password must be at least 5 characters long" do
  	@test_subject = User.new(name: "  ", email: "jokowi@private.com",password: '1', password_confirmation:'1')
  	assert_not @test_subject.valid?
  end

  test "user must be able to create a person object" do
  	@main_subject.save
  	@main_subject.create_person(description:'President of Indonesia',address:'Menteng',phone_number:'647647647')
  	assert_not @main_subject.person.nil?
  end

  test "user must be able to create a person object even when fields are empty" do
  	@main_subject.save
  	@main_subject.create_person(description:'',address:'',phone_number:'')
  	assert_not @main_subject.person.nil?
  end

end

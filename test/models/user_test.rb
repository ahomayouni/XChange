require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@main_subject = User.new(name: "Jokowi", email: "jokowi@private.com")
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

end

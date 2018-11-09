require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Jokowi", email: "jokowi@private.com")
  end

  test "password is not present" do
  	@test_subject = User.new(name: "Jokowi", email: "jokowi@private.com")
  	assert_not @test_subject.valid?
  end

  test "should not be valid" do
  	@test_subject = User.new(name: "Jokowi", email: "jokowi@private.com",password: '111111', password_confirmation:'111111')
  	assert @test_subject.valid?
  end
end

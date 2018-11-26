require 'rails_helper'

RSpec.describe Group, type: :model do
  context "Model Validation Tests" do
  	it "should create a group successfully when all the valid parameters are given" do 
  		@group = Group.new 
  		@group.name = "People of North York"
  		@group.description = "People living in the north york area looking to borrow and lend stuff"
  		@group.isPublic = true 
  		@group.save

  		expect(Group.all.count).to eq(1)
  		
  	end

  end
end

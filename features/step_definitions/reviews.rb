When("I fill in the text area {string} with: {string}") do |string,string1|
  fill_in string, with: string1 #This is the id of the input field. 
end

Then("I should be able to see the comments that was posted {string}") do |string| 
	within(".modal-content") do 
		expect(page).to have_content(string)
	end
end
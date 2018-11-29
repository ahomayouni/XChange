Feature: Account Signup
As a new user I would like to sign up when I hit the website url
at https://xchange-csc444.herokuapp.com

Scenario: User tries to create a new account with correct params
When I go to the home page
Then I should see a signup button
When I click the signup button
Then I should see a modal with neccessary fields
When I input my correct information
Then I should see an account being created 

Scenario: User tries to create a new account with invalid password confirmation
When I go to the home page
Then I should see a signup button
When I click the signup button
Then I should see a modal with neccessary fields
When I input my wrong password confirmation
Then I should an error message telling me to try signup again

Scenario: User tries to create a new account with no name
When I go to the home page
Then I should see a signup button
When I click the signup button
Then I should see a modal with neccessary fields
When I input my wrong fields with no name
Then I should an error message telling me to try signup again




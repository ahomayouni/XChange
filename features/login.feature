Feature: Account Login
As a returning user I would like to be able to login and acess the application 
at https://xchange-csc444.herokuapp.com

Scenario: User tries to login to his/her account with correct credentials
Given that I have already signed up and activated my account 
When I go to the home page
Then I should see a login button
When I click the login button
Then I should see a login modal with neccessary fields
When I input my correct login credentials
Then I should be able to login and see my dashboard
And I should be able to see notifications
When I logout
Then I should be redirected to the home landing page
Feature: Main Listing Feature
As a user I would like to be able to borrow listings from other people & lend out my listings.

Scenario: As a user, I must be able to send out a borrow request for a listing
Given that I am able to login as a user and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
Then I should see an item `saw` as it was already previously seeded
When I click the button view listing to view the item saw
Then I should see a borrow request button
When I click the borrow request button
Then I should see a modal pop up with next steps instructions on what to do

Scenario: As a lender, when someone sends me a borrow request, I must be able to view and approve it

Scenario: As a lender, when someone sends me a borrow request, I must be able to view and decline it
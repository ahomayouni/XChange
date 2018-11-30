Feature: Main Listing Feature
As a user I would like to be able to view,create,borrow,lend listings.

Scenario: User should be able to see all the available listings when browsing through listings
Given that I am able to login as a user and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
Then I should see an item `saw` as it was already previously seeded
And I should see an item `HP Office Printer` as it was already previously seeded
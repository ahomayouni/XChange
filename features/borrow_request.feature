Feature: Main Listing Feature
As a user I would like to be able to borrow listings from other people & lend out my listings.

# Scenario: As a user, I must be able to send out a borrow request for a listing
# Given that I am able to login as `cucumber_tester` and view my dashboard
# Given that I already have listings and other users seeded
# When I click listings in the top header
# Then I should see an item `saw` as it was already previously seeded
# When I click the button view listing to view the item saw
# Then I should see a borrow request button
# When I click the borrow request button no javascript mode
# Then I should see a modal pop up with next steps instructions on what to do

@javascript
Scenario: As a lender, when someone sends me a borrow request, I must be able to view and approve it. The borrower then will recieve a notification saying that his/her item has been approved.
Given that I am able to login as `cucumber_tester` and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
And I wait for "3" seconds
Then I should see an item `saw` as it was already previously seeded
When I click the button view listing to view the item saw
And I wait for "3" seconds
Then I should see a borrow request button
And I wait for "3" seconds
When I fill in the borrow request date range with string: "2018/11/30 - 2019/08/16"
And I wait for "3" seconds
When I click the button "Request Item" 
And I wait for "2" seconds 
Then I should see a modal pop up with next steps instructions on what to do
And I wait for "2" seconds
Then I click the my rentals button
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
Then I should be redirected to the home landing page
And I wait for "2" seconds
When I login with email: "peter@gmail.com" and password: "12345" and my name is: "Peter"
Then I would expect that "Peter" would have "1" notification in the database
And I wait for "2" seconds
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "initialBorrowRequest"
And I wait for "4" seconds
Then I will be redirected to pending approvals tab and see the listing item `saw` over there
When I click the link "Approve"
And I wait for "2" seconds
Then I should see a modal on successfull of approval
And I wait for "2" seconds
Then I click the button "Okay!"
And I wait for "1" seconds
When I logout
And I wait for "2" seconds
Then I should be redirected to the home landing page
And I wait for "2" seconds
When I login with email: "valid_user@gmail.com" and password: "111111" and my name is: "cucumber_tester"
And I wait for "1" seconds
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "approvedBorrowRequest"
And I wait for "5" seconds

@javascript
Scenario: As a lender, when someone sends me a borrow request, I must be able to view and decline it. The borrower then will receive a notification saying that his/her item has been declined.
Given that I am able to login as `cucumber_tester` and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
And I wait for "3" seconds
Then I should see an item `saw` as it was already previously seeded
When I click the button view listing to view the item saw
And I wait for "3" seconds
Then I should see a borrow request button
And I wait for "3" seconds
When I fill in the borrow request date range with string: "2018/11/30 - 2019/08/16"
And I wait for "3" seconds
When I click the button "Request Item"
And I wait for "2" seconds 
Then I should see a modal pop up with next steps instructions on what to do
And I wait for "2" seconds
Then I click the my rentals button
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
Then I should be redirected to the home landing page
And I wait for "2" seconds
When I login with email: "peter@gmail.com" and password: "12345" and my name is: "Peter"
Then I would expect that "Peter" would have "1" notification in the database
And I wait for "2" seconds
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "initialBorrowRequest"
And I wait for "4" seconds
Then I will be redirected to pending approvals tab and see the listing item `saw` over there
When I click the link "Decline"
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
Then I should be redirected to the home landing page
And I wait for "2" seconds
When I login with email: "valid_user@gmail.com" and password: "111111" and my name is: "cucumber_tester"
And I wait for "1" seconds
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "declinedBorrowRequest"
And I wait for "5" seconds

@javascript
Scenario: As a lender, when someone sends me a borrow request, I must be able to view and approve it. The borrower then will recieve a notification saying that his/her item has been approved. Then after the two parties (borrower and lender) has met , the lender has to mark the item as borrowed in his/her dashboard. 
Given that I am able to login as `cucumber_tester` and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
And I wait for "3" seconds
Then I should see an item `saw` as it was already previously seeded
When I click the button view listing to view the item saw
And I wait for "3" seconds
Then I should see a borrow request button
And I wait for "3" seconds
When I fill in the borrow request date range with string: "2018/11/30 - 2019/08/16"
And I wait for "3" seconds
When I click the button "Request Item" 
And I wait for "2" seconds 
Then I should see a modal pop up with next steps instructions on what to do
And I wait for "2" seconds
Then I click the my rentals button
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
Then I should be redirected to the home landing page
And I wait for "2" seconds
When I login with email: "peter@gmail.com" and password: "12345" and my name is: "Peter"
Then I would expect that "Peter" would have "1" notification in the database
And I wait for "2" seconds
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "initialBorrowRequest"
And I wait for "4" seconds
Then I will be redirected to pending approvals tab and see the listing item `saw` over there
When I click the link "Approve"
And I wait for "2" seconds
Then I should see a modal on successfull of approval
And I wait for "2" seconds
Then I click the button "Okay!"
And I wait for "2" seconds
Then I click the link "Items to Mark as Lent"
And I wait for "2" seconds
Then I click the button "Mark as Borrowed"
And I wait for "2" seconds
Then I should see a modal on successfull of borrowed
And I wait for "2" seconds
Then I click the button "Okay!"
And I wait for "2" seconds
When I logout
And I wait for "5" seconds

# Verify that the borrower request status is also switched to borrowed

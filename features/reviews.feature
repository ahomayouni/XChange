Feature: Main Listing Feature
As a user I would like to be able to review my experience of borrowing/lending items.

@javascript
Scenario: Once the whole borrowing and lending scenario is completed. Now the borrower must be able to make a review about the lender
Given that I am able to login as `cucumber_tester` and view my dashboard
Given that I already have listings and other users seeded
When I click listings in the top header
And I wait for "5" seconds
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
And I wait for "3" seconds
Then I click the link "Items to Mark as Returned"
And I wait for "2" seconds
Then I click the button "Mark as Returned"
And I wait for "2" seconds
Then I click the button "Okay!"
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
When I login with email: "valid_user@gmail.com" and password: "111111" and my name is: "cucumber_tester"
And I wait for "2" seconds
Then I click the link "My Rentals"
And I wait for "2" seconds
Then I click the link "Rate Peter"
And I wait for "4" seconds
When I fill in the text area "comment_body" with: "Thanks for the item! Always in good condition"
And I wait for "2" seconds
When I give a rating of "3" using the star icon dragger
And I wait for "2" seconds
Then I click the button "Add Review"
And I wait for "2" seconds
When I logout
And I wait for "2" seconds
When I login with email: "peter@gmail.com" and password: "12345" and my name is: "Peter"
When I click on the notifications button
And I wait for "2" seconds
When I click the notification with id "new_person_comment_notification"
And I wait for "2" seconds
Then I click the button "See Reviews"
And I wait for "2" seconds
Then I should be able to see the comments that was posted "Thanks for the item!"







# XChange

CSC-444 group project

## Live Application
* https://xchange-csc444.herokuapp.com
* Use admin account: admin@admin.com password: admin

## Installation:
To get this project running, follow these steps: 

 On a terminal, clone this repository and cd into it. Then, enter the below commands into the terminal. 
1. >bundle install --without production 
2. >rails db:migrate
3. >rails server 

## TODO:
* Peter - Primary Task: Help out Maru on frontend . Secondary Task: Incorporate User and Person Models with others
* Adi - Finish up Item Listing and possibly some simple chat application (?)
* Maru - Front End Lead 
* Arash - Work on User Circles  
* Arnav - Borrower Lender Ratings (should start finishing)
* KC - Main Welcome Landing Page Design - Fix footer positioning, Fix header styles, and look through other websites to get inspiration for a modern looking webpage.

## IceBox (Required within the Bolen Docs):
* Simple Chat/Messaging Application
* Push Notification (Say when I follow a User, I would be able to get notifications)

## Deployment
* Install heroku CLI installed on your computer
* (For mac users and assuming you have the all amazing `homebrew` installed)
1. >brew install heroku/brew/heroku

* If you have made new migrations, remember to also run db:migrate on HEROKU. 

1. >heroku run rails db:migrate

## General Comments
* Deadline : 4 weeks 
* Status : Aim to finish MAIN functionality by next week. 

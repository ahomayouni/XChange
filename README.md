# XChange

CSC-444 group project

## Live Application
* https://xchange-csc444.herokuapp.com

## Installation:
To get this project running, follow these steps: 

 On a terminal, clone this repository and cd into it. Then, enter the below commands into the terminal. 
1. >bundle install --without production 
2. >rails db:migrate
3. >rails server 


## TODO:
* Peter - Account Activation, Create a forgot password feature
* Adi - Item Listing
* Maru - Overall Aesthetics
* Arash - Deployment 
* Arnav - Borrower Lender Ratings
* KC - Help Arnav out and Overall Aesthetics

## IceBox (Required within the Bolen Docs):
* Header (with top able to show/hide certain links whether someone is logged in)
* Footer

## Deployment
* Make sure you have the heroku CLI installed in your computer
* (For mac users and assuming you have the all amazing `homebrew` installed)
1. >brew install heroku/brew/heroku

* If you have made new migrations, remember to also run db:migrate on HEROKU

1. >heroku run rails db:migrate

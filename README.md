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
* Adi - 1)Uploading multiple images 2)resizing images 3)Working on listings page frontend w/ Maru 4)Create models for requesting items if not in current inventory 5)Chat/messaging service
* Maru - Front End Lead
* Arash - Work on User Circles
* Arnav - Added comments for People - Linking comments to a listing as well - work with Maru on getting front end up & running
* KC - 1) Push in the Users page layout 2) Improve Login in and sign up pages 3) About, Privacy Policy, Terms of Service, Settings pages  

## Current Bugs:
* Anyone can edit anyone else's listing (Fixed by Maru)
* Anyone can delete anyone else's listing (Fixed by Peter)

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
* Status : Aim to finish MAIN functionality by next week, Wednesday November the 14th.
* Have not yet implemented Borrowing and Lending Functionality 

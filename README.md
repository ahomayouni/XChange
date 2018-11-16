# XChange

CSC-444 group project

## Installation:
To get this project running, follow these steps:

 On a terminal, clone this repository and cd into it. Then, enter the below commands into the terminal.
1. >bundle install --without production
2. >rails db:migrate
3. >rails server

## TODO:
* Peter - Implement testing framework with rspec and integrate notifications and authentication all around.
* Adi - 1)Uploading multiple images 2)resizing images 3)Working on listings page frontend w/ Maru 4)Create models for requesting items if not in current inventory 5)Chat/messaging service
* Maru - Front End Lead
* Arash - Work on User Circles
* Arnav - Added comments for People - Linking comments to a listing as well - work with Maru on getting front end up & running
* KC - 1) Push in the Users page layout 2) Improve Login in and sign up pages 3) About, Privacy Policy, Terms of Service, Settings pages  

## Current Bugs:
* Anyone can edit anyone else's listing (Fixed by Maru)
* Anyone can delete anyone else's listing (Fixed by Peter)
* Error for displaying rating when there is no rating (nil) (Fixed by Maru)

## Heroku Database (files disappearing):
* The Heroku filesystem is ephemeral - that means that any changes to the filesystem whilst the dyno is running only last until that dyno is shut down or restarted.
* Dynos will restart every day in a process known as "Cycling".
* Need someone to incorporate AWS S3 - otherwise static files such as images would be disappeared.
* Reference: https://help.heroku.com/K1PPS2WM/why-are-my-file-uploads-missing-deleted
* How to: https://devcenter.heroku.com/articles/paperclip-s3

## IceBox (Required within the Bolen Docs):
* Simple Chat/Messaging Application
* Push Notification (Say when I follow a User, I would be able to get notifications)
* Wizard / Step by Step sign up ( not required but would add to a "superb UI/UX"
* Report a listing - say if a listing does not seem legitamate, other users can report that listing. Then admin would be able to delete that listing if they find that it does not follow community guidelines 
* Potentially being able to upload a picture from mobile for your listing 
* Simple notice to users that we will use their location on sign up - if they say no, then just bring them back to the homepage. Really simple workflow, nothing over complicated

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

#Message Board

This App is Deplyed @ https://boiling-beach-61535.herokuapp.com/

This is a Simple Message Board App made wth Ruby on Rails(Ruby version 2.3.3 Rails version 5.1.2)
You can upload text, video, and image messages. 

##Getting Started on Mac

Install [RVM](https://rvm.io/) and [MySQL]()

cd into the message_board directory and run the following commands
```
#Installing Ruby Version for progect
rvm install "ruby-2.3.3"

#Changing into Ruby Version
rvm ruby-2.3.3

#Installing Rails Version
gem install rails -v 5.1.2

#Installing MySql if not installed
brew install mysql #or download MySQL installer for windows

#Installing gems
bundle install

#Updating gems
bundle update

#Updating mysql2 gem
bundle update mysql2

#Starting MySql server
mysql.server start

#Create database
rails db:create

#Run migrations
rails db:migrate

#Run server
rails s
```


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Configuration

Install the following:

 * Ruby

 * Rails

 * Git

 * Postgresql

 * elasticsearch 2.4.4 (download from here - https://www.elastic.co/downloads/past-releases)

 * heroku

For elastic search, unzip the download, enter the directory, and start the server by running:

    ./bin/elasticsearch

to test, open a different terminal and run:

     curl 'http://localhost:9200/?pretty'

Now clone this repo

    cd [repo]
    bundle install
    cp config/database.yml.example config/database.yml
    rails db:create db:migrate
    rails s

then navigate to localhost:3000!

For admin features check out http://localhost:3000/admin/login

##Deploy process to Heroku

If you haven't already logged in your Heroku account, follow the prompts to create a new SSH public key.

	$ heroku login

###Clone the repository

Use Git to clone mysascards-staging's source code to your local machine.

	$ heroku git:clone -a mysascards-staging

To see if it was successfully cloned use

    $ cd mysascards-staging
	$ git remote

###Deploy your changes

Make some changes to the code you just cloned and deploy them to Heroku using Git.

	$ git add .
	$ git commit -am "make it better"
	$ git push heroku master

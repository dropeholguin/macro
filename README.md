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

 * heroku

 * ImageMagick

 * elasticsearch 2.4.4 (download from here - https://www.elastic.co/downloads/past-releases)

 * Yarn

**ImageMagick** can be installed by

    Ubuntu: sudo apt-get install imagemagick
    macOS: brew install imagemagick

For **ElasticSearch**, unzip the download, enter the directory, and start the server by running:

    ./bin/elasticsearch

to test, open a different terminal and run:

     curl 'http://localhost:9200/?pretty'

To install **Yarn**
on Ubuntu:

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
    yarn --version

on macOS:

    brew install yarn


Now clone this repo

    cd [repo]
    bundle install
    cp config/database.yml.example config/database.yml
    rails db:create db:migrate
    rails s

then navigate to localhost:3000.

For admin features check out http://localhost:3000/admin/login

For client-side SPA, in a new terminal window

    yarn install
    ./bin/webpack-dev-server

then navigate (for now) to localhost:3000/react to visit SPA

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

###Running Tests

Now to run tests we have two options: Rake task and browser.

##Rake task

The jasmine-rails gem includes a Rake task spec:javascripts.

    $ bundle exec rake spec:javascripts

##Browser

Another benefit with the jasmine-rails gem is that it configures and mounts the Jasmine runner at `/specs` in your Rails app.

    http://localhost:3000/specs


### API

The API needs to be built with the knowledge that we will be separating the front end from the backend - so that the backend can service multiple domains.  All API definitions are to be kept up to date on swagger - https://app.swaggerhub.com/apis/rawsas/macro-cards/1.0.0
The swagger UI also allows APIs to be tested, using CURL.  Indeed, this is how API definitions will be tested before they are accepted as 'done' in JIRA.  To test an API you need the user email address, and the auth token.  To get the auth token, first log into the application / launch console / Application tab / Local Storage, and extract the `authentication_token` key.



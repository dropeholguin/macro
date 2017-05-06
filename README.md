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

clone the repo

    cd [repo]
    bundle install
    cp config/database.yml.example config/database.yml
    rails db:create db:migrate
    brew install elasticsearch
    rails s

then navigate to localhost:3000!

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Admin",email: 'admin1@example.com', password: 'password', password_confirmation: 'password')
user = User.find_by_email 'admin1@example.com'
user.add_role :admin

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

require "#{Rails.root}/db/gioco/db.rb"
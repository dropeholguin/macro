# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.new(name: "Admin", email: 'useradmin@example.com', password: 'password', password_confirmation: 'password')
user.skip_confirmation!
user.save!
user.add_role :admin

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

require "#{Rails.root}/db/gioco/db.rb"

puts "Creating Users"
users = User.create!([{ name: 'Pedro Luis Holguin', email: "dropeholguin1994@gmail.com", password: "123456", password_confirmation: "123456"}, {name: "Jairo chaverra", email: "plholguino@uqvirtual.edu.co", password: "123456", password_confirmation: "123456"}])

users.each do |user|
	user.skip_confirmation!
	user.save!
end

tags = ["SAS Programming", "SAS Macro", "DI Studio", "SAS Management Console", "Enterprise Guide", "Workspace Management"]
question_array = []

puts "Creating Questions"
(1..100).each do |num|
	user = users.shuffle.first
	question = Question.new(user_id: user.id, title: Faker::Book.title, description_markdown: Faker::Lorem.paragraph(2, true), explanation_markdown: Faker::Lorem.paragraph(2, true), choice: "simple")
  question.tag_list = tags.sample(2)
	question.save!
	question_array << question
end

puts "Creating Answers"
question_array.each do |question|                                            
  (1..3).each do |num|
  	if num != 3
  		Answer.create!(question_id: question.id, answer_markdown: Faker::Name.title, is_correct: false)                                                	
    else
    	Answer.create!(question_id: question.id, answer_markdown: Faker::Name.title, is_correct: true)
    end                                                
  end                                                                      
end

puts "Creating Topics"

Topic.create!([{ name: 'SAS Programming', desc: "Programming"}, {name: 'SAS Macro', desc: "Macro"},{name: 'DI Studio', desc: "Studio"},{name: 'SAS Management Console', desc: "Management Console"},{name: 'Enterprise Guide', desc: "Guide"},{name: 'Workspace Management', desc: "Management"}])

puts "Creating Sessions"
(1..2000).each do |num|
  user = users.shuffle.first
  session = Session.new(user_id: user.id, title: Faker::Book.title, tag: tags.sample)
  session.save!
end

sessions_array = Session.all
questions_array = Question.all

sessions_array.each do |session|
  (1..10).each do |num|                  
    question = questions_array.sample
    if !Take.session_takes(session.id).map(&:question_id).include?(question.id)
      take = Take.new(question_id: question.id, session_id: session.id)
      take.save!
    end
  end
end

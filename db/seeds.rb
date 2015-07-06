# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_number = 1
second_number = 1

10.times do
  10.times do
    Question.create(body: "#{first_number}*#{second_number}")
    second_number += 1
  end
  first_number += 1
  second_number = 1
end

Userquestionstat.create(user_id: 1, total_questions: 3, correct: 2, incorrect: 1)

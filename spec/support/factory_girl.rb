require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :userquestionstat do
    correct { rand(1..5) }
    incorrect { rand(1..5) }
    total_questions { correct + incorrect }
  end

end

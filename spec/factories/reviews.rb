require 'faker'

FactoryGirl.define do
  factory :review do
    user
    space
    evaluation  { Faker::Number.between(1, 5) }
    comment     { Faker::Lorem.paragraph }
  end
end

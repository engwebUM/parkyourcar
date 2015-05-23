require 'faker'

FactoryGirl.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    username      { Faker::Internet.user_name(5..25) }
    email         { Faker::Internet.free_email(username) }
    password      { Faker::Internet.password(8) }
    phone_number  { Faker::Number.between(100_000_000, 999_999_999) }
    # => consider changing phone_number from integer to string to avoid 'leading zero' problems
  end
end

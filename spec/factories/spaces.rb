require 'faker'

FactoryGirl.define do
  factory :space do
    user
    title             { Faker::Company.name }
    available_spaces  { Faker::Number.between(1, 9) }
    description       { Faker::Lorem.paragraph }
    country           { Faker::Address.country }
    city              { Faker::Address.city }
    address           { Faker::Address.street_name }
    post_code         { Faker::Address.postcode }
    price_hour        { Faker::Commerce.price }
    latitude          { Faker::Address.latitude }
    longitude         { Faker::Address.longitude }
    date_from         { DateTime.current - 1.year }
    date_until        { DateTime.current + 1.year }
    available_weekend { [true, false].sample }
  end
end

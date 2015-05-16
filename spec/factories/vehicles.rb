require 'faker'

FactoryGirl.define do
  factory :vehicle do
    user
    plate { Faker::Lorem.characters(6).upcase.scan(/.{2}/).join('-') } # e.g. 00-AA-00
    make  { Faker::Company.name }
    model { Faker::Commerce.product_name }
  end
end

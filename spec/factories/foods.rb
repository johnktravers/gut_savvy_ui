FactoryBot.define do
  factory :food do
    name { Faker::Food.unique.sushi }
    upc { Faker::Number.number(digits: 12).to_s }
    brand { Faker::Company.name }
  end
end

FactoryBot.define do
  factory :food do
    name { Faker::Food.sushi }
    upc { Faker::Number.number(digits: 12).to_s }
  end
end

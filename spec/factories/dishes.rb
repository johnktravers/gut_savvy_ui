FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
  end
end

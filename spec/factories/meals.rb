FactoryBot.define do
  factory :meal do
    title { 'Breakfast' }
    gut_feeling { Faker::Number.between(from: -5, to: 5) }
    user
  end
end

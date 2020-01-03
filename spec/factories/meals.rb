FactoryBot.define do
  factory :meal do
    title { Faker::Food.dish }
    gut_feeling { Faker::Number.between(from: -5, to: 5) }
    user
  end

  factory :unrated_meal, class: 'Meal' do
    title { Faker::Food.dish }
    user
  end
end

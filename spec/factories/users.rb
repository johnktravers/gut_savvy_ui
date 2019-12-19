FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    token { 'ba6089c326c800190b88746f8a2e13f7' }
    uid { '123456789' }
  end
end

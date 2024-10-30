FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    date { Faker::Date.forward(days: 30) }
    location { Faker::Address.city }
    association :organizer, factory: :user
  end
end

FactoryBot.define do
  factory :haiku do
    content               {Faker::String.random(length: 5..25)}

    association :user
    association :field
  end
end

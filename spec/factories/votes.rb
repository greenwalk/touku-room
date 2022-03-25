FactoryBot.define do
  factory :vote do
    association :user
    association :haiku
  end
end

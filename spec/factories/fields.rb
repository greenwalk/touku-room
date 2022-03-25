FactoryBot.define do
  factory :field do
    status              { rand(0..2) }

    association :theme
  end
end

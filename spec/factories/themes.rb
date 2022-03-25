FactoryBot.define do
  factory :theme do
    season_id           { rand(2..5) }

    association :user

    after(:build) do |theme|
      theme.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
    end
  end
end

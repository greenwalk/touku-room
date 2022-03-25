FactoryBot.define do
  factory :user do
    email                 {Faker::Internet.free_email}
    password              { '1a' + Faker::Internet.password(min_length: 8) }
    password_confirmation {password}
    name                  {Faker::Name.first_name}
    profile               {Faker::String.random(length: 0..200)}
  end
end
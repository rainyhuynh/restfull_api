FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    created_by {Faker::Number.to_s}
  end
end
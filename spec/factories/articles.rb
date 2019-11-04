FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: Random.new.rand(1..64)) }
    body { Faker::Lorem.characters }
    user

    trait :with_comment do
      comment
    end
  end
end

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: Random.new.rand(1..64)) }
    body { Faker::Lorem.characters }
    user_id { 1 }
  end
end

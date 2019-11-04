FactoryBot.define do
  factory :comment do
    body { Faker::Movies::HarryPotter.quote }
    user
    article
  end
end

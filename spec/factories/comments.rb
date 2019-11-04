FactoryBot.define do
  factory :comment do
    body { Faker::Movies::HarryPotter.quote }
    user_id { 1 }
    article_id { 1 }
    user
    article
  end
end

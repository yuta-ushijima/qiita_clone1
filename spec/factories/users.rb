FactoryBot.define do
  factory :user do
    name { Faker::Movies::HarryPotter.character }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_comment do
      comment
    end

    trait :with_article do
      article
    end
  end
end

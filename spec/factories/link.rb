FactoryBot.define do
  factory :link do
    body { Faker::Internet.url }
    base_url { 'http://localhost:3000' }
    slug { SecureRandom.urlsafe_base64(6) }

    trait :with_visits do
      after(:create) do |l|
        create_list :visit, 20, link: l
      end
    end
  end
end

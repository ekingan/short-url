FactoryBot.define do
  factory :link do
    body { Faker::Internet.url }
    base_url { 'http://localhost:3000' }
  end
end

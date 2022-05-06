FactoryBot.define do
  factory :item do
    name              { Faker::Name.name }
    price             { 100_000 }
    category_id       { 2 }
    condition_id      { 2 }
    charge_id         { 2 }
    prefecture_id     { 2 }
    date_id           { 2 }
    explanation       { '良いものです' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
    end
  end
end

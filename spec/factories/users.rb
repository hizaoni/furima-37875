FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             { '太郎' }
    first_name            { '山田' }
    last_name_kana        { 'タロウ' }
    first_name_kana       { 'ヤマダ' }
    birthday              { Faker::Date.between(from: '1935-01-01', to: Date.today) }
  end
end

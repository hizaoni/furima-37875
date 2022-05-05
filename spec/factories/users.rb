FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6, special_characters: false, mix_case: false) }
    password_confirmation { password }
    last_name             { '太郎' }
    first_name            { '山田' }
    last_name_kana        { 'タロウ' }
    first_name_kana       { 'ヤマダ' }
    birthday              { Faker::Date.between(from: '1935-01-01', to: Date.today) }
  end
end

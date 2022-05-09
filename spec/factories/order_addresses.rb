FactoryBot.define do
  factory :order_address do
    postal_code           { "111-1111" }
    prefecture_id         { 2 }
    municipality          { "札幌市" }
    house_number          { "時計台前" }
    building_name         { "札幌時計台1-1" }
    phone_number          { "00000000000" }
    token      {"tok_abcdefghijk00000000000000000"}

    
    
  end
end

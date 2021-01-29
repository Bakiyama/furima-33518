FactoryBot.define do
  factory :user_purchase do
    postal_code     { '111-1234' }
    area_id         { 2 }
    city            { '札幌市' }
    address         { '11-12' }
    telephone        { "09098765432" }
    token            {"tok_abcdefghijk00000000000000000"}
  end
end

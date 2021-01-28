FactoryBot.define do
  factory :user_purchase do
    postal_code     { '111-1234' }
    area_id         { 2 }
    city            { '札幌市' }
    address         { '11-12' }
    telephone        { "09098765432" }
  end
end

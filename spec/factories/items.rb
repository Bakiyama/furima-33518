FactoryBot.define do
  factory :item do
    name            {"テスト"}
    explain         {"これはテストコードです。"}
    category_id     {2}
    condition_id    {2}
    deliver_fee_id  {2}
    area_id         {2}
    ship_id         {2}
    price           {300}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/oasis1.jpg'), filename: 'oasis1.jpg')
    end
  end
end

FactoryBot.define do
  factory :user do
    nickname              {"テスト"}
    email                 {Faker::Internet.free_email}
    password = '1a' + Faker::Internet.password(min_length: 6)
    password              {password}
    password_confirmation {password}
    lastname_kanji        {"山田"}
    firstname_kanji       {"太郎"}
    lastname_kana         {"ヤマダ"}
    firstname_kana        {"タロウ"}
    birthday              {"1950-01-01"}
  end
end

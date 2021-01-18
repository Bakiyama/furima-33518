# テーブル設計

## users テーブル

| Column          | Type     | Options     |
| --------------- | -------- | ----------- |
| email           | string   | null: false |
| password        | string   | null: false |
| nickname        | string   | null: false |
| lastname_kanji  | string   | null: false |
| firstname_kanji | string   | null: false |
| lastname_kana   | string   | null: false |
| firstname_kana  | string   | null: false |
| birthday_year   | integer  | null: false |
| birthday_month  | integer  | null: false |
| birthday_date   | integer  | null: false |

### Association
- has_many :items
- has_many :Purchases


## Items テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| name         | string     | null: false       |
| explain      | text       | null: false       |
| category     | integer    | null: false       |
| condition    | integer    | null: false       |
| deliver_fee  | integer    | null: false       |
| area_from    | integer    | null: false       |
| ship         | integer    | null: false       |
| price        | integer    | null: false       |
| user         | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## Purchases テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| card_num       | integer    | null: false       |
| expire_month   | integer    | null: false       |
| expire_year    | integer    | null: false       |
| security_num   | integer    | null: false       |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |

### Association
- belongs_to :item
- has_one :recipient

## Recipients テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| postal_code  | integer    | null: false       |
| prefecture   | integer    | null: false       |
| city         | string     | null: false       |
| address      | string     | null: false       |
| building     | string     | null: false       |
| telephone    | integer    | null: false       |
| purchase     | references | foreign_key: true |

### Association
-belongs_to :purchase


# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| nickname           | string   | null: false               |
| lastname_kanji     | string   | null: false               |
| firstname_kanji    | string   | null: false               |
| lastname_kana      | string   | null: false               |
| firstname_kana     | string   | null: false               |
| birthday           | date     | null: false               |


### Association
- has_many :items
- has_many :purchases

## Items テーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| name            | string     | null: false       |
| explain         | text       | null: false       |
| category_id     | integer    | null: false       |
| condition_id    | integer    | null: false       |
| deliver_fee_id  | integer    | null: false       |
| area_id         | integer    | null: false       |
| ship_id         | integer    | null: false       |
| price           | integer    | null: false       |
| user            | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase
- has_many :categories
- has_many :conditions
- has_many :deliver_fees
- has_many :areas
- has_many :ships

## Purchases テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :recipient

## Recipients テーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| postal_code     | string     | null: false       |
| prefecture_id   | integer    | null: false       |
| city            | string     | null: false       |
| address         | string     | null: false       |
| building        | string     | null: false       |
| telephone       | string     | null: false       |
| purchase        | references | foreign_key: true |

### Association
- belongs_to :purchase



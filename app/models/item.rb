class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :condition
  belongs_to :deliver_fee
  belongs_to :ship

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :explain
    validates :price, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width number."}
    validates :image
  end

  with_options numericality: { other_than: 1 }, presence: true  do
    validates :category_id
    validates :condition_id
    validates :deliver_fee_id
    validates :area_id
    validates :ship_id
  end

  validates_inclusion_of :price, in:300..9999999, message: "is invalid."


end

# 商品画像を1枚つけることが必須であること@
# 商品名が必須であること@
# 商品の説明が必須であること@
# カテゴリーの情報が必須であること@
# 商品の状態についての情報が必須であること@
# 配送料の負担についての情報が必須であること@
# 発送元の地域についての情報が必須であること@
# 発送までの日数についての情報が必須であること@
# 価格についての情報が必須であること@
# 価格の範囲が、¥300~¥9,999,999の間であること@
# 販売価格は半角数字のみ保存可能であること@
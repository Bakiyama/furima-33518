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
    validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width number.' }
    validates :image
  end

  with_options numericality: { other_than: 1 }, presence: true do
    validates :category_id
    validates :condition_id
    validates :deliver_fee_id
    validates :area_id
    validates :ship_id
  end

  validates_inclusion_of :price, in: 300..9_999_999, message: 'is invalid.'
end

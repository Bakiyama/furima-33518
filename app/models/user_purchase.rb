class UserPurchase
  include ActiveModel::Model
  extend ActiveHash::Associations::ActiveRecordExtensions
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :city, :address, :building, :telephone, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  end

  with_options numericality: { other_than: 1 }, presence: true do
    validates :area_id
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'is invalid. Input full-width characters.' } do
    validates :city
  end

  validates :address, presence: true

  with_options format: { with: /\A\d{11}\z/, message: 'is invalid. Input 11 half-width number or less.' }, presence: true do
    validates :telephone
  end

  validates :token, presence: true 

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    Recipient.create(postal_code: postal_code, area_id: area_id, city: city, address: address, building: building, telephone: telephone, purchase_id: purchase.id)
  end
end

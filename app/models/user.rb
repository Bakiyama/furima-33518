class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthday, presence: true
  validates :password_confirmation, presence: true
  with_options presence: true do
    validates :lastname_kanji, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters." }
    validates :firstname_kanji, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width katakana characters." }
    validates :lastname_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input half-width characters." }
    validates :firstname_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input half-width characters." }
    validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: "is invalid. Input half-width characters." }
    validates :password_confirmation, format: { with: /\A[a-zA-Z0-9]+\z/, message: "is invalid. Input half-width characters." }
  end
end
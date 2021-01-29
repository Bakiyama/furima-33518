require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  before do
    @recipient = FactoryBot.build(:user_purchase)
  end

  context "配送先情報が保存できる場合" do
    it "配送先情報が全て入力されていること" do
      expect(@recipient).to be_valid
    end
  end

  context "配送先情報を保存できない場合" do
    it "配送先の情報として、郵便番号が必須であること" do
      @recipient.postal_code = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Postal code can't be blank")
    end

    it "郵便番号にはハイフンが必要であること（123-4567となる）" do
      @recipient.postal_code = "1231234"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it "郵便番号は半角数字での入力が必須であること" do
      @recipient.postal_code = "１２３-１２３４"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it "配送先の情報として、都道府県が必須であること" do
      @recipient.area_id = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Area is not a number", "Area can't be blank")
    end

    it "配送先の情報として、「---」を選ぶと保存できないこと（id: 1を選ぶと）" do
      @recipient.area_id = 1
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Area must be other than 1")
    end

    it "配送先の情報として、市区町村が必須であること" do
      @recipient.city = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("City can't be blank", "City is invalid. Input full-width characters.")
    end

    it "市区町村は全角での入力が必須であること" do
      @recipient.city = "Sapporo"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("City is invalid. Input full-width characters.")
    end

    it "市区町村は全角で数字を入力しても保存できないこと" do
      @recipient.city = "１１１１"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("City is invalid. Input full-width characters.")
    end

    it "配送先の情報として、番地が必須であること" do
      @recipient.address = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Address can't be blank")
    end

    it "配送先の情報として、電話番号が必須であること" do
      @recipient.telephone = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Telephone can't be blank")
    end

    it "電話番号にはハイフンは不要であること（09012345678となる）" do
      @recipient.telephone = "090-1233-1234"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Telephone is invalid. Input 11 half-width number or less.")
    end

    it "電話番号には１１文字以内であること" do
      @recipient.telephone = "061234123412"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Telephone is invalid. Input 11 half-width number or less.")
    end

    it "電話番号が半角数字での入力が必須であること" do
      @recipient.telephone = "０９０１２３４５６７８"
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Telephone is invalid. Input 11 half-width number or less.")
    end

    it "token（クレジットカード情報）ないと保存できない事" do
      @recipient.token = nil
      @recipient.valid?
      expect(@recipient.errors.full_messages).to include("Token can't be blank")
    end
  end
end
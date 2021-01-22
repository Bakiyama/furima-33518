require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '出品できない時' do
    it "商品画像を1枚つけることが必須であること" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it "商品名が必須であること" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "商品の説明が必須であること" do
      @item.explain = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Explain can't be blank")
    end

    it "カテゴリーの情報が必須であること" do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category is not a number", "Category can't be blank")
    end

    it "商品の状態についての情報が必須であること" do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition is not a number", "Condition can't be blank")
    end

    it "配送料の負担についての情報が必須であること" do
      @item.deliver_fee_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Deliver fee is not a number", "Deliver fee can't be blank")
    end

    it "発送元の地域についての情報が必須であること" do
      @item.area_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Area is not a number", "Area can't be blank")
    end
    
    it "発送までの日数についての情報が必須であること" do
      @item.ship_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Ship is not a number", "Ship can't be blank")
    end
    
    it "価格についての情報が必須であること" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank", "Price is invalid. Input half-width number.", "Price is invalid.")
    end
    
    it "価格が300円未満では登録できないこと" do
      @item.price = "299"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is invalid.")
    end

    it "価格が1000万円以上では登録できないこと" do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is invalid.")
    end
    
    it "販売価格は半角数字のみ保存可能であること" do
      @item.price = "５００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is invalid.")
    end
  end
end


# expect(@item.errors.full_messages).to include("")
# bundle exec rspec spec/models/item_spec.rb
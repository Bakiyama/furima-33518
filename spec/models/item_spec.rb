require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '出品できる時' do
    it '全ての欄を入力していると保存ができること' do
      expect(@item).to be_valid
    end
  end

  context '出品できない時' do
    it '商品画像を1枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.explain = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Explain can't be blank")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Category is not a number', "Category can't be blank")
    end

    it '商品の状態についての情報が必須であること' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition is not a number', "Condition can't be blank")
    end

    it '配送料の負担についての情報が必須であること' do
      @item.deliver_fee_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Deliver fee is not a number', "Deliver fee can't be blank")
    end

    it '発送元の地域についての情報が必須であること' do
      @item.area_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Area is not a number', "Area can't be blank")
    end

    it '発送までの日数についての情報が必須であること' do
      @item.ship_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Ship is not a number', "Ship can't be blank")
    end

    it '価格についての情報が必須であること' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is invalid. Input half-width number.',
                                                    'Price is invalid.')
    end

    it 'カテゴリーの情報は、1を選択している場合保存できないこと' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品の状態について、1を選択している場合保存できないこと' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 1')
    end

    it '配送料の負担について、1を選択している場合保存できないこと' do
      @item.deliver_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Deliver fee must be other than 1')
    end

    it '発送元の地域について、1を選択している場合保存できないこと' do
      @item.area_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Area must be other than 1')
    end

    it '発送までの日数について、1を選択している場合保存できないこと' do
      @item.ship_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Ship must be other than 1')
    end

    it '価格が300円未満では登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid.')
    end

    it '価格が1000万円以上では登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid.')
    end

    it '販売価格は半角数字のみ保存可能であること' do
      @item.price = '５００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid.')
    end

    it '販売価格は半角英数混合では登録できないこと' do
      @item.price = '1000a'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid.')
    end

    it '販売価格は半角英語では登録できないこと' do
      @item.price = 'tenthousand'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid.')
    end
  end
end

# expect(@item.errors.full_messages).to include("")
# bundle exec rspec spec/models/item_spec.rb

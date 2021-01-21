require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "全ての情報を記述していれば保存できること" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できないこと" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "メールアドレスが一意性であること" do
      @user.save
      anyUser = FactoryBot.build(:user, email: @user.email)
      anyUser.valid?
      expect(anyUser.errors.full_messages).to include("Email has already been taken")
    end
    
    it "メールアドレスは、@を含む必要があること" do
      @user.email = "aaahotmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password can't be blank", "Password is invalid. Input half-width characters.", "Password confirmation doesn't match Password")
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "12345a"
      @user.password_confirmation = "12345a"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = "1234567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードは、半角英数字混合での入力が必須であること" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
    end
  end

  describe 'ユーザー本人確認' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "ユーザー本名は、名字と名前がそれぞれ必須であること(姓がない場合)" do
      @user.lastname_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname kanji can't be blank", "Lastname kanji is invalid. Input full-width characters.")
    end

    it "ユーザー本名は、名字と名前がそれぞれ必須であること(名がない場合)" do
      @user.firstname_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname kanji can't be blank", "Firstname kanji is invalid. Input full-width characters.")
    end

    it "ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
      @user.lastname_kanji = "Yamada"
      @user.firstname_kanji = "Taro"
      @user.lastname_kana = "やまだ"
      @user.firstname_kana = "たろう"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname kanji is invalid. Input full-width characters.", "Firstname kanji is invalid. Input full-width characters.", "Lastname kana is invalid. Input full-width katakana characters.", "Firstname kana is invalid. Input full-width katakana characters.")
    end

    it "ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること（姓なし）" do
      @user.lastname_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname kana can't be blank", "Lastname kana is invalid. Input full-width katakana characters.")
    end

    it "ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること（名なし）" do
      @user.firstname_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname kana can't be blank", "Firstname kana is invalid. Input full-width katakana characters.")
    end

    it "ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること" do
      @user.lastname_kana = "やまだ"
      @user.firstname_kana = "たろう"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname kana is invalid. Input full-width katakana characters.", "Firstname kana is invalid. Input full-width katakana characters.")
    end

    it "生年月日が必須であること" do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
require 'rails_helper'

describe User do
  describe '#create' do
    # 1. nameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a name, email, password, password_confirmation" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    # 2. nameが空では登録できないこと
    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = FactoryBot.build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # 6. nameが7文字以上であれば登録できないこと
    it "is invalid with a name that has more than 7 characters " do
      user = FactoryBot.build(:user, name: "aaaaaaaa")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 6 characters)")
    end

    # 7. nameが6文字以下では登録できること
    it "is valid with a name that has less than 6 characters " do
      user = FactoryBot.build(:user, name: "aaaaaa")
      expect(user).to be_valid
    end

    # 8. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 9. passwordが8文字以上であれば登録できること
    it "is valid with a password that has more than 8 characters " do
      user = FactoryBot.build(:user, password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user).to be_valid
    end

    # 10. passwordが7文字以下であれば登録できないこと
    it "is invalid with a password that has less than 7 characters " do
      user = FactoryBot.build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end
  end
end
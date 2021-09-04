require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe "バリデーションのテスト" do
    it "ユーザー名、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
    end
    
    it "ユーザー名が10文字以下でなければ無効であること" do
      @user.name = "a" * 11
      @user.valid?
      expect(@user.errors[:name]).to include("は10文字以内で入力してください")
    end
    
    it "ユーザー名がなければ無効であること" do
       @user.name = nil # @user.nameがnilなら無効
       @user.valid?
       expect(@user.errors[:name]).to include("を入力してください")
    end
    
    it "重複したユーザー名なら無効な状態であること" do
      FactoryBot.create(:user)
      @user.valid?
      expect(@user.errors[:name]).to include("はすでに存在します")
    end
    
    it "パスワードが８文字以上でなければ無効であること" do
      @user.password = "a" * 7
      @user.valid?
      expect(@user.errors[:password]).to include("は8文字以上で入力してください")
    end
    
    it "パスワードがなければ無効であること" do
       @user.password = nil # @user.passwordがnilなら無効
       @user.valid?
       expect(@user.errors[:password]).to include("を入力してください")
    end
    
    it "パスワードと確認が一致していないと登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
  
end

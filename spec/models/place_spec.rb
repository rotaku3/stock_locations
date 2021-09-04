require 'rails_helper'

RSpec.describe Place, type: :model do
  before do
    @place = FactoryBot.build(:place)
   
  end
  
  describe "バリデーションのテスト" do
    it "撮影地、住所があれば有効な状態であること" do
      expect(@place).to be_valid
    end
    
    it "撮影地がなければ無効であること" do
       @place.name = nil # @user.nameがnilなら無効
       @place.valid?
       expect(@place.errors[:name]).to include("を入力してください")
    end
    
    it "住所がなければ無効であること" do
       @place.address = nil # @user.nameがnilなら無効
       @place.valid?
       expect(@place.errors[:address]).to include("を入力してください")
    end
    
    
    
    
    
  end
  
end
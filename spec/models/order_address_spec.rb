require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it 'itemとuserに紐づいていて、postal_codeとprefecture_idとmunicipalityとhouse_numberとphone_numberとtokenが存在していれば、購入できる' do
        expect(@order_address).to be_valid
      end

      it 'itemとuserに紐づいていて、postal_codeとprefecture_idとmunicipalityとphone_numberとtokenが存在していれば、購入できる（house_numberがなくても保存できる）' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'itemと紐づいていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'userと紐づいていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'postal_codeがないと購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'prefecture_idが1だと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'municipalityがないと購入できない' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市町村を入力してください")
      end

      it 'phone_numberがないと購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'house_numberrがないと購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'tokenがないと購入できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

      it 'postal_codeに(-)ハイフンがないと購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は半角数字で、ハイフン(-)を含めてください")
      end

      it 'phone_numberが半角英数字でないと購入できない' do
        @order_address.phone_number = '０００００００００００'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号\"電話番号は半角数字で、ハイフン（-)は除いてください\"")
      end

      it 'phone_numberが9桁以下だと購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
    end
  end
end

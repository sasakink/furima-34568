require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  describe '配送先住所と購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
      sleep(1)
    end

    context '内容に問題がない場合' do
      it ' 必須の値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_shipping_address.building_name = nil
        expect(@purchase_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空では保存できないこと' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号を入力してください', '郵便番号は(-)ハイフンを含めて入力してください')
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_shipping_address.postal_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号は(-)ハイフンを含めて入力してください')
      end
      it 'delivery_source_idを選択していないと保存できないこと' do
        @purchase_shipping_address.delivery_source_id = 0
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('都道府県を入力してください')
      end
      it 'cityが空では保存できないこと' do
        @purchase_shipping_address.city = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it 'addressが空では保存できないこと' do
        @purchase_shipping_address.address = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('番地を入力してください')
      end
      it 'phone_numberは空では保存できないこと' do
        @purchase_shipping_address.phone_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を入力してください', '電話番号は半角数字で入力してください')
      end
      it 'phone_numberは数字でないと保存できないこと' do
        @purchase_shipping_address.phone_number = 'a'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'phone_numberは全角数字では保存できないこと' do
        @purchase_shipping_address.phone_number = '１'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'phone_numberは11桁以内の数値のみ保存できること' do
        @purchase_shipping_address.phone_number = '123456789012'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は11桁以内で入力してください')
      end
      it 'phone_numberは英数混合では保存できないこと' do
        @purchase_shipping_address.phone_number = '1a'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は半角数字で入力してください')
      end
      it 'user_idは空では保存できなこと' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idは空では登録できないこと' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Itemを入力してください')
      end
      it 'tokenが空では保存できないこと' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
    end
  end
end

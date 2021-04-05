require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it 'nameとdescriptionとcategory_idとitem_condition_idとdelivery_fee_idとdelivery_source_idとdelivery_date_idとselling_priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない時' do
      it 'nameが空では出品できない' do
        @item.name = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では出品できない' do
        @item.description = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが「id:0 --」では出品できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end
      it 'item_condition_idが「id:0 --」では出品できない' do
        @item.item_condition_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item condition must be other than 0')
      end
      it 'delivery_fee_idが「id:0 --」では出品できない' do
        @item.delivery_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee must be other than 0')
      end
      it 'delivery_source_idが「id:0 --」では出品できない' do
        @item.delivery_source_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery source must be other than 0')
      end
      it 'delivery_date_idが「id:0 --」では出品できない' do
        @item.delivery_date_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery date must be other than 0')
      end
      it 'selling_priceが全角では出品できない' do
        @item.selling_price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが¥299以下では出品できない' do
        @item.selling_price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが¥10,000,000以上では出品できない' do
        @item.selling_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price は半角数字、¥300~¥9,999,999で入力してください。')
      end
    end
  end
end

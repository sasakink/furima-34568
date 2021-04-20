require 'rails_helper'

RSpec.describe Item, type: :model do
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
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('出品画像を入力してください')
      end
      it 'nameが空では出品できない' do
        @item.name = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'descriptionが空では出品できない' do
        @item.description = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'category_idが「id:0 --」では出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end
      it 'item_condition_idが「id:0 --」では出品できない' do
        @item.item_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end
      it 'delivery_fee_idが「id:0 --」では出品できない' do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end
      it 'delivery_source_idが「id:0 --」では出品できない' do
        @item.delivery_source_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end
      it 'delivery_date_idが「id:0 --」では出品できない' do
        @item.delivery_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end
      it 'selling_priceが空では出品できない' do
        @item.selling_price = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください', '販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが半角英語では出品できない' do
        @item.selling_price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが半角英数混合では出品できない' do
        @item.selling_price = '111aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが全角では出品できない' do
        @item.selling_price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが¥299以下では出品できない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
      it 'selling_priceが¥10,000,000以上では出品できない' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字、¥300~¥9,999,999で入力してください。')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントの保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @comment = FactoryBot.build(:comment, user_id: @user.id, item_id: @item.id)
      sleep(1)
    end

    context '内容に問題がない場合' do
      it 'textとuser_idとitem_idがあれば保存できる' do
        expect(@comment).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'textが空では保存できないこと' do
        @comment.text = ' '
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textを入力してください')
      end
      it 'user_idが空では保存できないこと' do
        @comment.user_id = ' '
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idが空では保存できないこと' do
        @comment.item_id = ' '
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
